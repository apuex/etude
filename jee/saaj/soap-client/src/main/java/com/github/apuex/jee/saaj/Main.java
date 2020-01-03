package com.github.apuex.jee.saaj;

import org.apache.commons.cli.*;

import javax.xml.namespace.QName;
import javax.xml.soap.*;
import java.io.FileInputStream;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class Main {
    public static void main(String args[]) throws Exception {
        final Options options = options();

        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);

        if (cmd.hasOption("h")) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("soap-message <options>", options);
            printOptions(defaultOptions());
        } else {
            final Map<String, String> params = defaultOptions();

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
        SOAPConnectionFactory soapConnectionFactory =
                SOAPConnectionFactory.newInstance();
        SOAPConnection connection =
                soapConnectionFactory.createConnection();

        MessageFactory factory = MessageFactory.newInstance(SOAPConstants.SOAP_1_2_PROTOCOL);
        SOAPMessage request = factory.createMessage();
        SOAPHeader header = request.getSOAPHeader();
        header.detachNode();
        SOAPBody body = request.getSOAPBody();
        QName requestBodyName = new QName(params.get("namespace-uri"), params.get("method"), "ns1");
        SOAPBodyElement bodyElement = body.addBodyElement(requestBodyName);
        QName name = new QName(params.get("parameter-name"));
        SOAPElement symbol = bodyElement.addChildElement(name);
        symbol.addTextNode(request(params.get("request-file")));
        request.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "utf-8");
        request.setProperty(SOAPMessage.WRITE_XML_DECLARATION, "true");

        URL endpoint = new URL(params.get("endpoint-url"));
        SOAPMessage response = connection.call(request, endpoint);
        connection.close();

        if (params.containsKey("verbose")) {
            printOptions(params);
            request.writeTo(System.out);
            response.writeTo(System.out);
        }

        SOAPBody soapBody = response.getSOAPBody();

        soapBody.getChildElements()
                .forEachRemaining(o -> {
                    SOAPElement output = (SOAPElement) o;
                    output.getChildElements()
                            .forEachRemaining(r -> {
                                SOAPElement returnVal = (SOAPElement) r;
                                System.out.println(returnVal.getValue());
                            });
                });
    }

    public static Map<String, String> defaultOptions() {
        return new HashMap<String, String>() {{
            put("endpoint-url", "http://FSUService.chinamobile.com");
            put("namespace-uri", "http://FSUService.chinamobile.com");
            put("method", "invoke");
            put("output", "invokeResponse");
            put("return", "invokeReturn");
            put("parameter-name", "xmlData");
            put("request-file", "GetFsuInfoRequest.xml");
        }};
    }

    public static void printOptions(Map<String, String> options) {
        System.out.println("current options are:");
        int maxLength = options.entrySet().stream()
                .map(x -> x.getKey().length())
                .max((x, y) -> {
                    if (x < y) return -1;
                    else if (x > y) return 1;
                    else return 0;
                })
                .get() + 1;

        options.entrySet().forEach(e -> System.out.printf("  %s = %s\n", paddingRight(e.getKey(), maxLength), e.getValue()));
    }

    public static String paddingRight(String s, int maxWidth) {
        int length = s.length();
        StringBuilder sb = new StringBuilder();
        sb.append(s);
        if(length < maxWidth) {
            for (int i = length; i < maxWidth; ++i) {
                sb.append(' ');
            }
        }
        return sb.toString();
    }

    public static Options options() {
        final Options options = new Options();
        options.addOption(new Option("e", "endpoint-url", true, "SOAP service endpoint URL."));
        options.addOption(new Option("n", "namespace-uri", true, "SOAP service namespace URI."));
        options.addOption(new Option("m", "method", true, "method to be invoked."));
        options.addOption(new Option("p", "parameter-name", true, "method parameter."));
        options.addOption(new Option("f", "request-file", true, "name of file contains parameter value."));
        options.addOption(new Option("v", "verbose", false, "print out options and transport details."));
        options.addOption(new Option("h", "help", false, "print help message."));
        return options;
    }

    public static String request(String requestFileName) throws Exception {
        FileInputStream f = new FileInputStream(requestFileName);
        byte[] bytes = new byte[f.available()];
        f.read(bytes);
        f.close();
        return new String(bytes, Charset.forName("utf-8"));
    }
}
