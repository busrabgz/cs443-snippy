package com.snippy.app;

import static com.snippy.libs.Config.SetupFirestore;
import static com.snippy.libs.Config.SetupJedis;
import static com.snippy.libs.Config.getDb;
import static com.snippy.libs.Config.getJedis;
import static com.snippy.libs.Config.getAuth;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.WriteResult;

@SpringBootApplication
@RestController
public class AppApplication {


	public static void main(String[] args) {

		SetupFirestore();
		SetupJedis();

		SpringApplication.run(AppApplication.class, args);
	}


	@GetMapping("logs/{id}")
	public String logs(@PathVariable(value="id") String id) throws Exception {
		var db = getDb();
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
		var db = getDb();
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
		var jedis = getJedis();
		jedis.set("foo", "bar");

		String value = jedis.get("foo");
		System.out.println("GOT:" + value);

		return String.format("Hello from app 2 %s!", name);
	}

	@Operation(summary = "Checks health status of the microservices")
	@ApiResponses(
		value={
			@ApiResponse(
			responseCode = "200",
			description = "The status of the services are described in the content body.",
			content = @Content
			)
		}
	)
	@GetMapping("/healthcheck")
	public String healthCheck() {

		var db = getDb();
		var jedis = getJedis();
		// create a client
		var client = HttpClient.newHttpClient();

		var authStatus = false;
		try {
			authStatus = getAuth().getUser("lnSE1qjnn1R70TwfWomSPzqmx7Q2").getEmail().compareTo("dogacel@gmail.com") == 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		boolean analyticsStatus = false;

		try {
			var analyticsRequest = HttpRequest.newBuilder(URI.create("http://analytics-service:8080/sync")).build();
			var analyticsResponse = client.send(analyticsRequest, BodyHandlers.ofString()).body();
			analyticsStatus = analyticsResponse.compareTo("analytics") == 0;
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}

		var redisResponse = jedis.isConnected();
		var firestoreStatus = db != null;

		if (firestoreStatus) {
			try {
				db.document("doc/test").get().get(5000, TimeUnit.MILLISECONDS);
			} catch (Exception e) {
				firestoreStatus = false;
			}
		}

		return String.format("App status: up<br/>Auth status: %s<br/>Analytics status: %s<br/>Redis status: %s<br/>Firestore status: %s", 
				authStatus ? "up" : "down",
				analyticsStatus ? "up" : "down",
				redisResponse ? "up" : "down",
				firestoreStatus ? "up" : "down");
	}

}
