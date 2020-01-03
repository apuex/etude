package com.github.apuex.jee.saaj;

import org.apache.commons.cli.*;

import javax.xml.namespace.QName;
import javax.xml.soap.*;
import java.io.FileInputStream;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String args[]) throws Exception {
        final Options options = new Options();
        options.addOption(new Option("e", "endpoint-url", true, "SOAP service endpoint URL."));
        options.addOption(new Option("n", "namespace-uri", true, "SOAP service namespace URI."));
        options.addOption(new Option("m", "method", true, "method to be invoked."));
        options.addOption(new Option("p", "parameter-name", true, "method parameter."));
        options.addOption(new Option("f", "request-file", true, "name of file contains parameter value."));
        options.addOption(new Option("h", "help", false, "print help message."));
        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);

        if (cmd.hasOption("h")) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("soap-message", options);
        } else {
            final Map<String, String> params = defaultSettings();

            options.getOptions().stream()
                    .forEach(o -> {
                        if (cmd.hasOption(o.getOpt())) {
                            params.put(o.getLongOpt(), cmd.getOptionValue(o.getOpt()));
                        }
                    });

            invoke(params);
        }
    }

    public static void invoke(Map<String, String> params) throws Exception {
        MessageFactory factory = MessageFactory.newInstance(SOAPConstants.SOAP_1_2_PROTOCOL);
        SOAPMessage message = factory.createMessage();
        SOAPHeader header = message.getSOAPHeader();
        header.detachNode();
        SOAPBody body = message.getSOAPBody();
        QName bodyName = new QName(params.get("namespace-uri"), params.get("method"), "m");
        SOAPBodyElement bodyElement = body.addBodyElement(bodyName);
        QName name = new QName(params.get("parameter-name"));
        SOAPElement symbol = bodyElement.addChildElement(name);
        symbol.addTextNode(request(params.get("request-file")));
        message.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "utf-8");
        message.setProperty(SOAPMessage.WRITE_XML_DECLARATION, "true");
        message.writeTo(System.out);
    }

    public static Map<String, String> defaultSettings() {
        return new HashMap<String, String>() {{
            put("endpoint-url", "http://FSUService.chinamobile.com");
            put("namespace-uri", "http://FSUService.chinamobile.com");
            put("method", "invoke");
            put("parameter-name", "xmlData");
            put("request-file", "GetFsuInfoRequest.xml");
        }};
    }

    public static String request(String requestFileName) throws Exception {
        FileInputStream f = new FileInputStream(requestFileName);
        byte[] bytes = new byte[f.available()];
        f.read(bytes);
        f.close();
        return new String(bytes, Charset.forName("utf-8"));
    }
}
