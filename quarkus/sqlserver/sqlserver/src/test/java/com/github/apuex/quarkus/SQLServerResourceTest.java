package com.github.apuex.quarkus;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class SQLServerResourceTest {

    @Test
    public void testHelloEndpoint() {
        given()
          .when().get("/sqlserver")
          .then()
             .statusCode(200)
             .body(is("hello"));
    }

}