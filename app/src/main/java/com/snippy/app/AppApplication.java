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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.firestore.WriteResult;;

@SpringBootApplication
@RestController
public class AppApplication {

	static Firestore db;

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

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World") String name) throws Exception {

		for (var item : db.listCollections())
			System.out.println(item.getPath());

		System.out.println("Hey!");

		var docRef = db.document("doc/test");
		Map<String, Object> data = new HashMap<>();
		data.put("first", "Ada");
		data.put("last", "Lovelace");
		data.put("born", 1815);
		// asynchronously write data
		ApiFuture<WriteResult> result = docRef.set(data);
		// ...
		// result.get() blocks on response
		System.out.println("Update time : " + result.get().getUpdateTime());

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
