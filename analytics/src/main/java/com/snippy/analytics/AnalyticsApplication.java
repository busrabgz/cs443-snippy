package com.snippy.analytics;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;


import static com.snippy.libs.Config.getDb;

import java.util.ArrayList;
import java.util.List;
import com.google.gson.*;

import com.google.cloud.firestore.SetOptions;
import com.snippy.libs.Request;

@SpringBootApplication
@RestController
public class AnalyticsApplication {

	public static void main(String[] args) {
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
	public void saveRequest(@PathVariable String id, @RequestBody String body) throws Exception {
		var db = getDb();
		long incoming_time = Long.parseLong(body);
		long outgoing_time = System.currentTimeMillis();
		Request newReq = new Request(incoming_time, outgoing_time);
		
		/*
		var docRef = db.collection("requests").document(id).get();
		if(docRef.get().exists()){
			db.collection("requests").document(id).update("history",);
		}
		else {}*/
		List<Request> history = new ArrayList<>();
		history.add(newReq);
		db.collection("requests").document(id).set(history, SetOptions.merge());
	}

	@GetMapping("/analytics/{id}")
	public String getAnalytics(@PathVariable String id) throws Exception {
		var db = getDb();

		var docRef = db.collection("requests").document(id).get();
		List<Request> history = docRef.get().toObject(ArrayList.class);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		return gson.toJson(history);
	}

}
