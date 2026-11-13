package com.oracle.example;

import java.sql.DriverManager;
import java.sql.SQLException;

import io.micronaut.runtime.EmbeddedApplication;
import io.micronaut.context.annotation.Property;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.client.HttpClient;
import io.micronaut.http.client.annotation.Client;
import io.micronaut.http.client.exceptions.HttpClientResponseException;
import io.micronaut.test.extensions.junit5.annotation.MicronautTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

import jakarta.inject.Inject;

@MicronautTest
@Property(name = "oracle.jdbc-url", value = "jdbc:oracle:thin:@localhost:1521/test")
@Property(name = "oracle.username", value = "test")
@Property(name = "oracle.password", value = "test")
class GraphvizDemoTest {

    @Inject
    EmbeddedApplication<?> application;

    @Inject
    @Client("/")
    HttpClient client;

    @Test
    void testItWorks() {
        Assertions.assertTrue(application.isRunning());
    }

    @Test
    void homepageIsServed() {
        String homepage = client.toBlocking().retrieve("/");
        Assertions.assertTrue(homepage.contains("Human Resources Visualization"));
    }

    @Test
    void missingResourceReturnsNotFound() {
        HttpClientResponseException exception = Assertions.assertThrows(
                HttpClientResponseException.class,
                () -> client.toBlocking().retrieve("/missing-resource.js"));
        Assertions.assertEquals(HttpStatus.NOT_FOUND, exception.getStatus());
        String body = exception.getResponse().getBody(String.class).orElseThrow();
        Assertions.assertTrue(body.contains("Page Not Found"));
        Assertions.assertTrue(body.contains("/missing-resource.js"));
    }

    @Test
    void oracleJdbcDriverIsAvailable() throws SQLException {
        Assertions.assertNotNull(DriverManager.getDriver("jdbc:oracle:thin:@localhost:1521/test"));
    }

}
