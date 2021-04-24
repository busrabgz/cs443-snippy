package com.snippy.app;

import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse.BodyHandlers;
import java.net.http.HttpRequest.BodyPublishers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;

import org.apache.commons.validator.routines.UrlValidator;
import org.springdoc.core.converters.models.Pageable;
import org.springdoc.core.converters.models.PageableAsQueryParam;
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
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

@RestController
public class UrlController {

	public String getUrl(String id) throws Exception {
		var db = getDb();
		var jedis = getJedis();

		String actualUrl = jedis.get(id);
		if (actualUrl != null)
			return actualUrl;

		var docRef = db.collection("urls").document(id).get();
		Url shortUrl = (Url) docRef.get(10000, TimeUnit.MILLISECONDS).toObject(Url.class);
		return shortUrl.getUrl();
	}

	@Operation(summary = "Redirects a shortened URL to the original URL")
	@GetMapping("/u/{id}")
	public ResponseEntity<Void> redirectToURL(@PathVariable String id) {
		String incoming_time = String.valueOf(System.currentTimeMillis());
		String actualUrl = null;
		try {
			actualUrl = getUrl(id);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String redirectUrl = "redirect:" + actualUrl == null ? "https://www.cloudflare.com/404/" : actualUrl;

		System.out.println("GOING");

		var client = HttpClient.newHttpClient();
		var analyticsRequest = HttpRequest.newBuilder(URI.create("http://analytics-service:8080/analytics/" + id))
				.POST(BodyPublishers.ofString(incoming_time)).header("content-type", "application/json").build();

		try {
			var body = client.send(analyticsRequest, BodyHandlers.ofString()).body();
			System.out.println(body);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(redirectUrl)).build();
	}

	@Operation(summary = "Gets the original URL from the shortened URL.")
	@GetMapping("/urls/{id}")
	public ResponseEntity<String> getUrlForId(@PathVariable String id) {
		try {
			String shortUrl = getUrl(id);
			return ResponseEntity.status(HttpStatus.OK).body(shortUrl);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("");
		}
	}

	@Operation(summary = "Creates a shortened URL for the user.")
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
		try {
			db.document("urls/" + shortUrl.getId()).create(shortUrl).get(10000, TimeUnit.MILLISECONDS);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.OK).body(shortUrl.getId());
	}

	@Operation(summary = "Creates a shortened URL with the defined id for the user.")
	@RequestMapping(value = "/namedUrls", method = RequestMethod.POST)
	public ResponseEntity<String> createNamed(@RequestBody Url url, @RequestHeader("fa-auth") String auth) throws InterruptedException, ExecutionException, TimeoutException {
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
			db.document("urls/" + url.getId()).create(url).get(10000, TimeUnit.MILLISECONDS);

			return ResponseEntity.status(HttpStatus.OK).body(url.getId());
		}

	}

	@Operation(summary = "Queries the urls created by the current user.")
	@PageableAsQueryParam
	@GetMapping("/urls")
	public ResponseEntity<List<Url>> getUrlForUser(@RequestHeader("fa-auth") String auth, @Parameter(hidden=true) Pageable pageable)
			throws Exception {
		var db = getDb();

		FirebaseToken token;
		try {
			token = FirebaseAuth.getInstance().verifyIdToken(auth);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		var ref = db.collection("urls/")
		.whereEqualTo("ownerEmail", token.getEmail())
		.offset(pageable.getPage() * pageable.getSize())
		.limit(pageable.getSize());

		QuerySnapshot snapshot = ref.get().get(10000, TimeUnit.MILLISECONDS);

		var retList = new ArrayList<Url>();
		for (DocumentSnapshot doc : snapshot) {
			retList.add(doc.toObject(Url.class));
		}

		return ResponseEntity.status(HttpStatus.OK).body(retList);
	}

}
