package com.snippy.libs;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.io.FileInputStream;
import java.time.Duration;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;

public class Config {

  private static JedisPoolConfig buildPoolConfig() {
    final JedisPoolConfig poolConfig = new JedisPoolConfig();
    poolConfig.setMaxTotal(128);
    poolConfig.setMaxIdle(128);
    poolConfig.setMinIdle(16);
    poolConfig.setTestOnBorrow(true);
    poolConfig.setTestOnReturn(true);
    poolConfig.setTestWhileIdle(true);
    poolConfig.setMinEvictableIdleTimeMillis(Duration.ofSeconds(60).toMillis());
    poolConfig.setTimeBetweenEvictionRunsMillis(Duration.ofSeconds(30).toMillis());
    poolConfig.setNumTestsPerEvictionRun(3);
    poolConfig.setBlockWhenExhausted(true);
    return poolConfig;
  }

  private static JedisPool jedisPool;

  public static void SetupJedis() {
    jedisPool = new JedisPool(buildPoolConfig(), "redis-service", 6379, 4000);

    var useEmulator = System.getenv("FIRESTORE_EMULATOR_HOST") != null;

    if (useEmulator)
      jedisPool.getResource().flushAll();
  }

  private static FirestoreOptions firestoreOptions;
  private static FirebaseOptions firebaseOptions;

  public static void SetupFirestore() {
    try {

      var useEmulator = System.getenv("FIRESTORE_EMULATOR_HOST") != null;

      var credentialPath = "/home/env/key.json";
      var serviceAccount = new FileInputStream(credentialPath);
      var credentials = GoogleCredentials.fromStream(serviceAccount);

      if (useEmulator) {
        firestoreOptions = FirestoreOptions.newBuilder().setProjectId("snippy-me-cs443").build();
        firebaseOptions = FirebaseOptions.builder()
        .setCredentials(credentials)
        .setDatabaseUrl(System.getenv("FIRESTORE_EMULATOR_HOST"))
        .setProjectId("snippy-me-cs443").build();

      } else {
        firestoreOptions = FirestoreOptions.newBuilder().setCredentials(credentials).setProjectId("snippy-me-cs443").build();
        firebaseOptions = FirebaseOptions.builder().setCredentials(credentials).setProjectId("snippy-me-cs443").build();
      }

      FirebaseApp.initializeApp(firebaseOptions);

      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static FirebaseAuth getAuth() {

    var inst = FirebaseAuth.getInstance(FirebaseApp.getInstance());
    return inst;
  }

  public static Firestore getDb() {
    return firestoreOptions.getService();
  }

  public static Jedis getJedis() {
    return jedisPool.getResource();
  }
}
