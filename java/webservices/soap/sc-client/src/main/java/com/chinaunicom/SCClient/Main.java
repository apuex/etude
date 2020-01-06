package com.chinaunicom.SCClient;
import com.chinaunicom.SCService.SCService;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.io.FileInputStream;
import java.net.URL;
import java.nio.charset.Charset;

public class Main {
    public static void main(String args[ ]) throws Exception {
        if(args.length < 3) usage();
        else invoke(args[0], args[1], args[2]);

    }

    private static void invoke(String qNameAsString,
                               String urlString,
                               String requestFileName) throws Exception {
        URL url = new URL(urlString);
        // Qualified name of the service:
        //   1st arg is the service URI
        //   2nd is the service name published in the WSDL
        QName qname = QName.valueOf(qNameAsString);
        // Create, in effect, a factory for the service.
        Service service = Service.create(url, qname);
        // Extract the endpoint interface, the service "port".
        SCService eif = service.getPort(SCService.class);
        FileInputStream f = new FileInputStream(requestFileName);
        byte[] bytes = new byte[f.available()];
        f.read(bytes);
        System.out.println(eif.invoke(new String(bytes, Charset.forName("utf-8"))));
        f.close();
    }

    private static void usage() {
        System.out.println("Usage:\n" +
                "    java -jar \n" +
                "\t<this jar> \n" +
                "\t<qname as string> \n" +
                "\t<url> \n" +
                "\t<request file>\n");
    }
}
