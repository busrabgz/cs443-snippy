package com.snippy.libs;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.io.FileInputStream;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;

import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.cloud.FirestoreClient;

import java.util.UUID;

import org.threeten.bp.Duration;

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
  private static FirebaseApp firebaseApp;

  public static void SetupJedis() {
    jedisPool = new JedisPool(buildPoolConfig(), "redis-service", 6379, 4000);

    var useEmulator = System.getenv("FIRESTORE_EMULATOR_HOST") != null;

    if (useEmulator)
      jedisPool.getResource().flushAll();
  }

  public static void SetupFirestore() {

    try {

      var credentialPath = "/home/env/key.json";
      var serviceAccount = new FileInputStream(credentialPath);
      var credentials = GoogleCredentials.fromStream(serviceAccount);

      var firebaseOptions = FirebaseOptions.builder().setCredentials(credentials).setProjectId("snippy-me-cs443")
          .setConnectTimeout(5000).setReadTimeout(5000).build();
      firebaseApp = FirebaseApp.initializeApp(firebaseOptions, UUID.randomUUID().toString());

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static FirebaseAuth getAuth() {
    if (firebaseApp == null)
      SetupFirestore();
    return FirebaseAuth.getInstance(firebaseApp);
  }

  public static Firestore getDb() {
    if (firebaseApp == null)
      SetupFirestore();
    return FirestoreClient.getFirestore(firebaseApp);
  }

  public static Jedis getJedis() {
    return jedisPool.getResource();
  }
}
