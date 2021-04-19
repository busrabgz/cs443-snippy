package com.snippy.libs;

import com.google.common.hash.Hashing;
import java.nio.charset.StandardCharsets;

public class Url {
 
    private String id;
    private String url;
    private int redirect;

    public Url() {
        this("", "");
    }

    public Url(String id, String url) {
        this.id = id;
        this.url = url;
        this.redirect = 0;
    }
 
    public static Url create(String url) {
        String id = Hashing.murmur3_32().hashString(url, StandardCharsets.UTF_8).toString();
        return new Url(id, url);
    }

    public String getId(){
        return this.id;
    }

    public String getUrl() {
        return this.url;
    }

    public String getRedirectCount() {
        return this.redirect;
    }
}