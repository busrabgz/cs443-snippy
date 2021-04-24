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
import java.util.concurrent.TimeUnit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import io.swagger.v3.oas.annotations.Operation;

@SpringBootApplication
@RestController
public class AppApplication {
	public static void main(String[] args) {

		SetupFirestore();
		SetupJedis();

		SpringApplication.run(AppApplication.class, args);
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

	@Operation(summary = "Returns health status of the all microservices.")
	@GetMapping("/healthcheck")
	public String healthCheck() {

		// create a client
		var client = HttpClient.newHttpClient();

		var authStatus = false;
		try {
			authStatus = getAuth().getUser("lnSE1qjnn1R70TwfWomSPzqmx7Q2").getEmail()
					.compareTo("dogacel@gmail.com") == 0;
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

		var jedis = getJedis();
		var redisResponse = jedis.isConnected();
		jedis.close();

		var db = getDb();
		var firestoreStatus = db != null;

		if (firestoreStatus) {
			try {
				db.document("doc/test").get().get(10000, TimeUnit.MILLISECONDS);
			} catch (Exception e) {
				firestoreStatus = false;
			} finally {

			}
		}

		return String.format(
				"App status: up<br/>Auth status: %s<br/>Analytics status: %s<br/>Redis status: %s<br/>Firestore status: %s",
				authStatus ? "up" : "down", analyticsStatus ? "up" : "down", redisResponse ? "up" : "down",
				firestoreStatus ? "up" : "down");
	}

}
