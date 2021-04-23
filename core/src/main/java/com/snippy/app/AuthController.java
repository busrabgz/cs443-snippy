package com.snippy.app;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;


@RestController
public class AuthController {
    
    private static final String BASE_URL = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/";
    private static final String OPERATION_AUTH = "verifyPassword";

	public static class EmailPassword {
		public String email;
		public String password;
        public EmailPassword() {
            this("", "");
        }

        public EmailPassword(String email, String password) {
            this.email = email;
            this.password = password;
        }
	}

    @Operation(summary = "A middle-man for the authentication with the firebase services.")
    @PostMapping("/auth")
    public String auth(@RequestBody EmailPassword pair) { 

        HttpURLConnection urlRequest = null;
        String token = null;

        try {
            URL url = new URL(BASE_URL+OPERATION_AUTH+"?key="+System.getenv("FIREBASE_API_KEY"));
            urlRequest = (HttpURLConnection) url.openConnection();
            urlRequest.setDoOutput(true);
            urlRequest.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            OutputStream os = urlRequest.getOutputStream();
            OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");
            osw.write("{\"email\":\""+pair.email+"\",\"password\":\""+pair.password+"\",\"returnSecureToken\":true}");
            osw.flush();
            osw.close();

            urlRequest.connect();

            JsonElement root = JsonParser.parseReader(new java.io.InputStreamReader((InputStream) urlRequest.getContent()));
            JsonObject rootobj = root.getAsJsonObject();

            token = rootobj.get("idToken").getAsString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            urlRequest.disconnect();
        }

        return token;
    }
}
