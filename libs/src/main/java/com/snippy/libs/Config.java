package com.snippy.libs;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.time.Duration;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;

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
  }

  private static FirestoreOptions firestoreOptions;

  public static void SetupFirestore() {
    try {
      firestoreOptions = FirestoreOptions.getDefaultInstance().toBuilder().setProjectId("snippy-me-cs443").build();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static Firestore getDb() {
    return firestoreOptions.getService();
  }

  public static Jedis getJedis() {
    return jedisPool.getResource();
  }
}
