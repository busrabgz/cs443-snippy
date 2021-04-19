package com.snippy.app;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.apache.commons.validator.routines.UrlValidator;
import com.snippy.libs.Url;

import static com.snippy.libs.Config.getDb;
import static com.snippy.libs.Config.getJedis;

import java.net.URI;

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

	@PostMapping("/urls")
	public String create(@RequestBody String url) {
		var db = getDb();
		var jedis = getJedis();

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

	@GetMapping("/urls/{id}")
	public String getUrlForId(@PathVariable String id) throws Exception {
		String shortUrl = getUrl(id);
		return shortUrl == null ? "No such url exists." : shortUrl;
	}

	@GetMapping("/u/{id}")
	public ResponseEntity<Void> redirectToURL(@PathVariable String id) throws Exception {
		String actualUrl = getUrl(id);
		String redirectUrl = "redirect:" + actualUrl == null ? "https://www.cloudflare.com/404/" : actualUrl;

		int redirectCount = db.document("urls/" + id).get("redirect");
		redirectCount++;
		db.collection("urls").document(id).update("redirect", redirectCount);
		
		return ResponseEntity.status(HttpStatus.FOUND).location(URI.create(redirectUrl)).build();
	}
}
