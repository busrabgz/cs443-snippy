package com.snippy.analytics;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

	@GetMapping("/analytics/{id}")
	public String getAnalytics(@PathVariable String id) throws Exception {
		int redirectCount = db.document("urls/" + id).get("redirect");
		// Other analytics to get here...

		response = {
			"redirectCount": redirectCount
			// Other analytics to be returned here...
		}
		return response;
	}

}
