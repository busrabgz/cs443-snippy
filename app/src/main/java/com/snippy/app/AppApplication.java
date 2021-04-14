package com.snippy.app;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController; 

import redis.clients.jedis.Jedis;


import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.firestore.WriteResult;;

@SpringBootApplication
@RestController
public class AppApplication {

	static Firestore db;
	static Jedis jedis;

	public static void main(String[] args) {

		try {
			FirestoreOptions firestoreOptions = FirestoreOptions.getDefaultInstance().toBuilder()
					.setProjectId("snippy-me-cs443").build();

			db = firestoreOptions.getService();
			System.out.println(db.document("doc/test"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		SpringApplication.run(AppApplication.class, args);
	}

	@GetMapping("logs/{id}")
	public String logs(@PathVariable(value="id") String id) throws Exception {
		var docRef = db.document("logs/"+id);
		var doc = docRef.get();
		var snapshot = doc.get();

		if (!snapshot.exists()) {
			return "Log does not exist.";
		}

		String result = "";
	
		for (var kv : snapshot.getData().entrySet()) {
			result += kv.getKey() + " : " + kv.getValue().toString() + "<br/>";
		}

		return result;
	}

	@GetMapping("/collections")
	public String collections() throws Exception {
		String collections = "";
		for (var item : db.listCollections())
			collections += item.getPath();

		var docRef = db.document("logs/collections");

		ApiFuture<WriteResult> result;
		if (docRef.get().get().exists()) {
			result = docRef.update("" + System.currentTimeMillis(), "accessed");
		} else {
			HashMap<String, Object> data = new HashMap<>();
			data.put("" + System.currentTimeMillis(), "accessed");
			result = docRef.create(data);
		}

		System.out.println("Update time : " + result.get().getUpdateTime());

		return collections;
	}

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
		Jedis jedis = new Jedis("redis-service", 6379);
		jedis.set("foo", "bar");
		String value = jedis.get("foo");
		System.out.println("GOT:" + value);

		return String.format("Hello from app 2 %s!", name);
	}

	@GetMapping("/sync")
	public String sync() {
		return "app";
	}

	@GetMapping("/healthcheck")
	public String healthCheck() {

		// create a client
		var client = HttpClient.newHttpClient();

		boolean authStatus = false, analyticsStatus = false;
		// use the client to send the request
		try {
			var authRequest = HttpRequest.newBuilder(URI.create("http://auth-service:8080/sync")).build();
			var authResponse = client.send(authRequest, BodyHandlers.ofString()).body();
			authStatus = authResponse.compareTo("auth") == 0;
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}

		try {
			var analyticsRequest = HttpRequest.newBuilder(URI.create("http://analytics-service:8080/sync")).build();
			var analyticsResponse = client.send(analyticsRequest, BodyHandlers.ofString()).body();
			analyticsStatus = analyticsResponse.compareTo("analytics") == 0;
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}

		return String.format("App status: up<br/>Auth status: %s<br/>Analytics status: %s", authStatus ? "up" : "down",
				analyticsStatus ? "up" : "down");
	}

}
