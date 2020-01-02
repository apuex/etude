package com.github.apuex.java.webservice;

import javax.jws.WebService;

@WebService(endpointInterface = "com.github.apuex.java.webservice.SCService")
public class SCServerImpl implements SCService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
