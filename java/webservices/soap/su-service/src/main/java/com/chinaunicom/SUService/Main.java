package com.chinaunicom.SUService;

import javax.xml.ws.Endpoint;

public class Main {
    public static void main(String[] args) {
        // 1st argument is the publication URL
        // 2nd argument is an SIB instance
        Endpoint.publish("http://127.0.0.1:8080/services/FSUService?wsdl", new SU());
    }
}
