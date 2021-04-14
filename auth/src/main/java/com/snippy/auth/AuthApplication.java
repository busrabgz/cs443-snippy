package com.snippy.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;

@SpringBootApplication
@RestController
public class AuthApplication {

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

		SpringApplication.run(AuthApplication.class, args);
	}

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
		return String.format("Hello from auth %s!", name);
	}
	
	@GetMapping("/sync")
	public String sync() {
		return "auth";
	}

}
