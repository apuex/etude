package com.github.apuex.jee.saaj;

import org.apache.commons.cli.*;

import javax.xml.namespace.QName;
import javax.xml.soap.*;
import java.io.FileInputStream;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String args[]) throws Exception {
        final Options options = options();

        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);

        if (cmd.hasOption("h")) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("soap-client <options>", options);
            printOptions(defaultOptions());
        } else {
            final Map<String, String> params = defaultOptions();

            options.getOptions().stream()
                    .forEach(o -> {
                        if (cmd.hasOption(o.getOpt())) {
                            params.put(o.getLongOpt(), cmd.getOptionValue(o.getOpt()));
                        }
                    });

            System.out.println(invoke(params));
        }
    }

    public static String invoke(Map<String, String> params) throws Exception {
        SOAPConnectionFactory soapConnectionFactory =
                SOAPConnectionFactory.newInstance();
        SOAPConnection connection =
                soapConnectionFactory.createConnection();

        SOAPMessage request = createSoapMessage(params);

        URL endpoint = new URL(params.get("endpoint-url"));
        SOAPMessage response = connection.call(request, endpoint);
        connection.close();

        if (params.containsKey("verbose")) {
            printOptions(params);
            request.writeTo(System.out);
            response.writeTo(System.out);
        }

        SOAPBody soapBody = response.getSOAPBody();

        if (soapBody.hasFault()) {
            throw new RuntimeException(faultMessage(response));
        } else {
            return getReturnXml(soapBody);
        }
    }


    public static Map<String, String> defaultOptions() {
        return new HashMap<String, String>() {{
            put("endpoint-url", "http://FSUService.chinamobile.com");
            put("namespace-uri", "http://FSUService.chinamobile.com");
            put("method", "invoke");
            put("output", "invokeResponse");
            put("return", "invokeReturn");
            put("soap-version", "1.1");
            put("parameter-name", "xmlData");
            put("request-xml-file", "GetFsuInfoRequest.xml");
        }};
    }

    public static void printOptions(Map<String, String> options) {
        System.out.println("current options are:");
        int maxLength = options.entrySet().stream()
                .map(x -> x.getKey().length())
                .max(Integer::compare)
                .get() + 1;

        options.entrySet().forEach(e -> System.out.printf("  %s = %s\n", paddingRight(e.getKey(), maxLength), e.getValue()));
    }

    public static String paddingRight(String s, int maxWidth) {
        int length = s.length();
        StringBuilder sb = new StringBuilder();
        sb.append(s);
        if (length < maxWidth) {
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
        options.addOption(new Option("s", "soap-version", true, "soap specification version, valid options are 1.1, 1.2, 1.1, default is 1.1"));
        options.addOption(new Option("f", "request-xml-file", true, "name of file contains parameter value."));
        options.addOption(new Option("x", "request-xml", true, "name of file contains parameter value."));
        options.addOption(new Option("v", "verbose", false, "print out options and transport details."));
        options.addOption(new Option("h", "help", false, "print help message."));
        return options;
    }


    private static SOAPMessage createSoapMessage(Map<String, String> params) throws Exception {

        MessageFactory factory;
        if("1.1".equals(params.getOrDefault("soap-version", "1.1"))) {
            factory = MessageFactory.newInstance(SOAPConstants.SOAP_1_1_PROTOCOL);
        } else if("1.2".equals(params.get("soap-version"))) {
            factory = MessageFactory.newInstance(SOAPConstants.SOAP_1_2_PROTOCOL);
        } else {
            throw new Exception(String.format("invalid soap specification version: '%s'", params.get("soap-version")));
        }
        SOAPMessage message = factory.createMessage();
        SOAPHeader header = message.getSOAPHeader();
        header.detachNode();
        SOAPBody body = message.getSOAPBody();
        QName requestBodyName = new QName(params.get("namespace-uri"), params.get("method"), "ns1");
        SOAPBodyElement bodyElement = body.addBodyElement(requestBodyName);
        QName name = new QName(params.get("parameter-name"));
        SOAPElement symbol = bodyElement.addChildElement(name);
        symbol.addTextNode(params.getOrDefault("request-xml", request(params.get("request-xml-file"))));
        message.setProperty(SOAPMessage.CHARACTER_SET_ENCODING, "utf-8");
        message.setProperty(SOAPMessage.WRITE_XML_DECLARATION, "true");
        return message;
    }

    public static String request(String requestFileName) throws Exception {
        FileInputStream f = new FileInputStream(requestFileName);
        byte[] bytes = new byte[f.available()];
        f.read(bytes);
        f.close();
        return new String(bytes, Charset.forName("utf-8"));
    }

    private static String getReturnXml(SOAPBody soapBody) {
        StringBuilder sb = new StringBuilder();
        soapBody.getChildElements()
                .forEachRemaining(o -> {
                    SOAPElement output = (SOAPElement) o;
                    output.getChildElements()
                            .forEachRemaining(r -> {
                                SOAPElement returnVal = (SOAPElement) r;

                                String v = returnVal.getValue();
                                if (v != null) sb.append(v);
                            });
                });
        return sb.toString();
    }

    public static String faultMessage(SOAPMessage message) throws Exception {
        StringBuilder sb = new StringBuilder();
        SOAPFault soapFault = message.getSOAPBody().getFault();
        sb.append(soapFault.getFaultCode())
                .append(": ")
                .append(soapFault.getFaultString());
        if(soapFault.hasDetail()) {
            soapFault.getDetail().getDetailEntries()
                    .forEachRemaining(e -> {
                        DetailEntry entry = (DetailEntry) e;
                        sb.append(entry.getValue());
                    });
        } else {
        }
        return sb.toString();
    }
}
