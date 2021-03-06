package com.github.apuex.java.webservice;
import com.github.apuex.java.webservice.TimeServer;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.net.URL;

public class Main {
    public static void main(String args[ ]) throws Exception {
        URL url = new URL(args[0]);
        // Qualified name of the service:
        //   1st arg is the service URI
        //   2nd is the service name published in the WSDL
        QName qname = new QName("http://webservice.java.apuex.github.com/", "TimeServerImplService");
        // Create, in effect, a factory for the service.
        Service service = Service.create(url, qname);
        // Extract the endpoint interface, the service "port".
        TimeServer eif = service.getPort(TimeServer.class);
        System.out.println(eif.getTimeAsString());        System.out.println(eif.getTimeAsElapsed());
    }
}
