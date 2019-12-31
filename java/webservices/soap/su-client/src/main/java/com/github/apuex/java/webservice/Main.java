package com.github.apuex.java.webservice;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.io.FileInputStream;
import java.net.URL;
import java.nio.charset.Charset;

public class Main {
    public static void main(String args[ ]) throws Exception {
        if(args.length < 2) usage();
        else invoke(args[0], args[1]);

    }

    private static void invoke(String urlString, String requestFileName) throws Exception {
        URL url = new URL(urlString);
        // Qualified name of the service:
        //   1st arg is the service URI
        //   2nd is the service name published in the WSDL
        QName qname = new QName("http://SUService.chinaunicom.com", "SUServiceService");
        // Create, in effect, a factory for the service.
        Service service = Service.create(url, qname);
        // Extract the endpoint interface, the service "port".
        SUService eif = service.getPort(SUService.class);
        FileInputStream f = new FileInputStream(requestFileName);
        byte[] bytes = new byte[f.available()];
        f.read(bytes);
        System.out.println(eif.invoke(new String(bytes, Charset.forName("utf-8"))));
        f.close();
    }

    private static void usage() {
        System.out.println("Usage:" +
                "\t java -jar <this jar> <url> <request file>\n");
    }
}
