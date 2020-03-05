package com.chinaunicom.SCService;

import javax.xml.ws.Endpoint;

public class Main {
    public static void main(String[] args) {
        // 1st argument is the publication URL
        // 2nd argument is an SIB instance
        Endpoint.publish("http://0.0.0.0:8080/services/SCService", new SCService());
    }
}
