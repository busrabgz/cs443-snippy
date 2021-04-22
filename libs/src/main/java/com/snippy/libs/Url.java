package com.snippy.libs;

import com.google.common.hash.Hashing;
import java.nio.charset.StandardCharsets;

public class Url {
 
    private String id;
    private String url;
    private String ownerEmail;

    public Url() {
        this("", "", "");
    }

    public Url(String id, String url, String email) {
        this(id, url);
        this.ownerEmail = email;
    }

    public Url(String id, String url) {
        this.id = id;
        this.url = url;
    }
 
    public static Url create(String url) {
        return Url.create(url, "");
    }

    public static Url create(String url, String email) {
        String id = Hashing.murmur3_32().hashString(url+email, StandardCharsets.UTF_8).toString();
        return new Url(id, url, email);
    }

    public String getId(){
        return this.id;
    }

    public String getUrl() {
        return this.url;
    }

    public String getOwnerEmail() {
        return this.ownerEmail;
    }

    public void setOwnerEmail(String email) {
        this.ownerEmail = email;
    }
}