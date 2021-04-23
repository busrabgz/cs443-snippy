package com.snippy.analytics;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import static com.snippy.libs.Config.SetupFirestore;
import static com.snippy.libs.Config.SetupJedis;
import static com.snippy.libs.Config.getDb;
import static com.snippy.libs.Config.getJedis;
import static com.snippy.libs.Config.getAuth;
import static com.snippy.libs.Config.getDb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.*;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.FieldValue;
import com.google.firebase.database.GenericTypeIndicator;
import com.snippy.libs.Request;

@SpringBootApplication
@RestController
public class AnalyticsApplication {

	public static void main(String[] args) {

		SetupFirestore();
		SetupJedis();

		SpringApplication.run(AnalyticsApplication.class, args);
	}

	@GetMapping("/")
	public String rootPath() {
		return "OK";
	}

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
		return String.format("Hello from analytics %s!", name);
	}

	@GetMapping("/sync")
	public String sync() {
		return "analytics";
	}

	@PostMapping("/analytics/{id}")
	public ResponseEntity<?> saveRequest(@PathVariable String id, @RequestBody String body) {
		var db = getDb();
		long incoming_time = Long.parseLong(body);
		long outgoing_time = System.currentTimeMillis();
		Request newReq = new Request(incoming_time, outgoing_time);

		DocumentReference docRef = db.collection("requests").document(id);

		try {
			if(!docRef.get().get().exists()) {
				Map<String, Object> map = new HashMap<>();
				map.put("history", new ArrayList<Request>());
				docRef.set(map).get();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}
	
		docRef.update("history", FieldValue.arrayUnion(newReq));
		return ResponseEntity.ok().build();
	}

	@GetMapping("/analytics/{id}")
	public ResponseEntity<List<Request>> getAnalytics(@PathVariable String id) {
		var db = getDb();

		var docRef = db.collection("requests").document(id).get();
		try {
			List<Request> history = (ArrayList<Request>) docRef.get().get("history");
			return history != null ? ResponseEntity.ok(history) : ResponseEntity.notFound().build();
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.notFound().build();
		}
	}

}
