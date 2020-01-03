package com.github.apuex.java.webservice;

import javax.jws.WebService;

@WebService(endpointInterface = "com.github.apuex.java.webservice.FSUService")
public class FSUServerImpl implements FSUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
