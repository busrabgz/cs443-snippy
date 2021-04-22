package com.snippy.app;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import org.apache.commons.validator.routines.UrlValidator;

import org.springframework.http.MediaType;

import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.snippy.libs.Url;

import static com.snippy.libs.Config.getDb;
import static com.snippy.libs.Config.getJedis;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

@RestController
public class UrlController {

	public String getUrl(String id) throws Exception {
		var db = getDb();
		var jedis = getJedis();

		String actualUrl = jedis.get(id);
		if (actualUrl != null)
			return actualUrl;

		var docRef = db.document("urls/" + id).get();
		Url shortUrl = (Url) docRef.get().toObject(Url.class);
		return shortUrl.getUrl();
	}

	@GetMapping("/u/{id}")
	public ResponseEntity<Void> redirectToURL(@PathVariable String id) throws Exception {
		String actualUrl = getUrl(id);
		String redirectUrl = "redirect:" + actualUrl == null ? "https://www.cloudflare.com/404/" : actualUrl;
		return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(redirectUrl)).build();
	}

	@GetMapping("/urls/{id}")
	public ResponseEntity<String> getUrlForId(@PathVariable String id) {
		try {
			String shortUrl = getUrl(id);
			return ResponseEntity.status(HttpStatus.OK).body(shortUrl);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("");
		}
	}

	@RequestMapping(value = "/urls", method = RequestMethod.POST, consumes = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody String url,
			@RequestHeader(name = "fa-auth", required = false) String auth) {
		var db = getDb();
		var jedis = getJedis();

		if (url.startsWith("\"") && url.endsWith(("\"")))
			url = url.substring(1, url.length() - 1);

		UrlValidator urlValidator = new UrlValidator(new String[] { "http", "https" });
		if (!urlValidator.isValid(url)) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid URL.");
		}

		var email = "";
		try {
			var token = FirebaseAuth.getInstance().verifyIdToken(auth);
			email = token.getEmail();
		} catch (Exception e) {
		}

		Url shortUrl = Url.create(url, email);

		jedis.set(shortUrl.getId(), shortUrl.getUrl());
		db.document("urls/" + shortUrl.getId()).create(shortUrl);
		return ResponseEntity.status(HttpStatus.OK).body(shortUrl.getId());
	}

	@RequestMapping(value = "/namedUrls", method = RequestMethod.POST)
	public ResponseEntity<String> create(@RequestBody Url url, @RequestHeader("fa-auth") String auth) {
		var db = getDb();
		var jedis = getJedis();

		FirebaseToken token;
		try {
			token = FirebaseAuth.getInstance().verifyIdToken(auth);
			url.setOwnerEmail(token.getEmail());
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("");
		}

		UrlValidator urlValidator = new UrlValidator(new String[] { "http", "https" });
		if (!urlValidator.isValid(url.getUrl())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid URL.");
		}

		try {
			getUrl(url.getId());

			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("URL name already exists.");
		} catch (Exception e) {
			jedis.set(url.getId(), url.getUrl());
			db.document("urls/" + url.getId()).create(url);

			return ResponseEntity.status(HttpStatus.OK).body(url.getId());
		}

	}

	@GetMapping("/userUrls")
	public ResponseEntity<List<Url>> getUrlForUser(@RequestHeader("fa-auth") String auth) throws Exception {
		var db = getDb();

		FirebaseToken token;
		try {
			token = FirebaseAuth.getInstance().verifyIdToken(auth);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		var ref = db.collection("urls/").whereEqualTo("ownerEmail", token.getEmail());

		QuerySnapshot snapshot = ref.get().get();

		var retList = new ArrayList<Url>();
		for (DocumentSnapshot doc : snapshot) {
			retList.add(doc.toObject(Url.class));
		}

		return ResponseEntity.status(HttpStatus.OK).body(retList);
	}

}
