package com.github.apuex.java.webservice;

import javax.jws.WebService;

@WebService(endpointInterface = "com.github.apuex.java.webservice.SUService")
public class SUServerImpl implements SUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
