package com.snippy.app;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Parameter;

import org.apache.commons.validator.routines.UrlValidator;

import org.springframework.http.MediaType;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.internal.FirebaseTokenFactory;
import com.google.firebase.auth.internal.FirebaseTokenVerifier;
import com.snippy.libs.Url;


import static com.snippy.libs.Config.getDb;
import static com.snippy.libs.Config.getJedis;

import java.lang.reflect.Array;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import javax.print.attribute.standard.Media;

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

	@RequestMapping(value="/urls", method = RequestMethod.POST, consumes = MediaType.TEXT_PLAIN_VALUE)
	public String create(@RequestBody String url) {
		var db = getDb();
		var jedis = getJedis();

		if (url.startsWith("\"") && url.endsWith(("\"")))
			url = url.substring(1, url.length() - 1);

		UrlValidator urlValidator = new UrlValidator(new String[] { "http", "https" });
		if (!urlValidator.isValid(url)) {
			return "Url is not valid.";
		}

		Url shortUrl = Url.create(url);

		System.out.println("GOT:" + shortUrl.getId());
		jedis.set(shortUrl.getId(), shortUrl.getUrl());

		db.document("urls/" + shortUrl.getId()).create(shortUrl);

		return shortUrl.getId();
	}

	@RequestMapping(value="/namedUrls", method = RequestMethod.POST)
	public ResponseEntity<String> create(@RequestBody Url url, @RequestHeader("fa-auth") String auth) {
		var db = getDb();
		var jedis = getJedis();


		System.out.println(url.getId() + " " + url.getUrl());

		UrlValidator urlValidator = new UrlValidator(new String[] { "http", "https" });
		if (!urlValidator.isValid(url.getUrl())) {
			return new ResponseEntity<String>("Url is not valid.", HttpStatus.BAD_REQUEST);
		}

		try { 
			getUrl(url.getId());
	
			return new ResponseEntity<String>("Url already taken.", HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			jedis.set(url.getId(), url.getUrl());
			db.document("urls/" + url.getId()).create(url);

			return new ResponseEntity<String>(url.getId(), HttpStatus.OK);
		}

	}

	@GetMapping("/urls")
	public List<String> getUrlForUser(@RequestHeader("fa-auth") String auth) throws Exception {
		
		var retList = new ArrayList<String>(); 

		FirebaseToken token = FirebaseAuth.getInstance().verifyIdToken(auth);

		System.out.println("Auth is: " + auth);



		return retList;
	}

	@GetMapping("/urls/{id}")
	public String getUrlForId(@PathVariable String id) throws Exception {
		String shortUrl = getUrl(id);
		return shortUrl == null ? "No such url exists." : shortUrl;
	}

	@GetMapping("/u/{id}")
	public ResponseEntity<Void> redirectToURL(@PathVariable String id) throws Exception {		
		String actualUrl = getUrl(id);
		String redirectUrl = "redirect:" + actualUrl == null ? "https://www.cloudflare.com/404/" : actualUrl;
		return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(redirectUrl)).build();
	}
}
