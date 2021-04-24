package com.snippy.app;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonParser;
import com.snippy.libs.User;
import com.google.firebase.auth.ExportedUserRecord;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.ListUsersPage;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @Operation(summary = "Queries all users if the request comes from admin.")
    @PostMapping("/users")
    public ResponseEntity<List<String>> getUsers(@RequestBody String email) { 
        ListUsersPage page = null;
        String admin = "admin@snippy.me";
        if(email.equals('"' + admin + '"')){
            try {
                page = FirebaseAuth.getInstance().listUsers(null);
                System.out.println(page);
            } catch (FirebaseAuthException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            var retList = new ArrayList<String>();
            while (page != null){
                for (ExportedUserRecord user: page.getValues()){
                    retList.add(user.getEmail());
                }
                page = page.getNextPage();
            }
            return ResponseEntity.status(HttpStatus.OK).body(retList);
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
    }
}
