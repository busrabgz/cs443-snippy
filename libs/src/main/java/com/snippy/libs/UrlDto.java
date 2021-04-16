package com.snippy.libs;

import com.google.common.hash.Hashing;
import lombok.AllArgsConstructor;
import lombok.Getter;
 
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
 
@Getter
@AllArgsConstructor
public class UrlDto {
 
    private final String id;
    private final String url;
    private final LocalDateTime created;
 
    public static UrlDto create(final String url) {
        final String id = Hashing.murmur3_32().hashString(url, StandardCharsets.UTF_8).toString();
        return new UrlDto(id, url, LocalDateTime.now());
    }
}