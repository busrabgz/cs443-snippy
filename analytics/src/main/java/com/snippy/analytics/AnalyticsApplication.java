package com.snippy.analytics;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import io.swagger.v3.oas.annotations.Operation;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

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
import java.util.concurrent.TimeUnit;

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

	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("*");
			}
		};
	}

	@Operation(summary = "Used for healtchecking by the Kubernetes services.")
	@GetMapping("/")
	public String rootPath() {
		return "OK";
	}

	@Operation(summary = "Used for healtchecking by the App service.")
	@GetMapping("/sync")
	public String sync() {
		return "analytics";
	}

	@Operation(summary = "Logs an incoming request to the given short URL.")
	@PostMapping("/analytics/{id}")
	public ResponseEntity<?> saveRequest(@PathVariable String id, @RequestBody long incoming_time) {
		var db = getDb();
		long outgoing_time = System.currentTimeMillis();
		Request newReq = new Request(incoming_time, outgoing_time);

		DocumentReference docRef = db.collection("requests").document(id);

		System.out.println("GOT IT");

		try {
			if (!docRef.get().get(10000, TimeUnit.MILLISECONDS).exists()) {
				Map<String, Object> map = new HashMap<>();
				var list = new ArrayList<Request>();
				list.add(newReq);
				map.put("history", newReq);
				var resp = docRef.create(map);
				resp.get(10000, TimeUnit.MILLISECONDS);

				System.out.println(resp);
			} else {
				docRef.update("history", FieldValue.arrayUnion(newReq)).get(10000, TimeUnit.MILLISECONDS);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.badRequest().build();
		}

		return ResponseEntity.ok().build();
	}

	@Operation(summary = "Gets the access history of the given short URL.")
	@GetMapping("/analytics/{id}")
	public ResponseEntity<List<Request>> getAnalytics(@PathVariable String id,
			@RequestHeader(name = "fa-auth") String auth) {
		var db = getDb();

		try {
			var docRef = db.collection("requests").document(id).get();
			List<Request> history = (ArrayList<Request>) docRef.get(10000, TimeUnit.MILLISECONDS).get("history");
			return history != null ? ResponseEntity.ok(history) : ResponseEntity.notFound().build();
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.notFound().build();
		}
	}

}
