package com.chinaunicom.SUService;

import com.chinaunicom.SUService.SUService;

import javax.jws.WebService;

@WebService(endpointInterface = "com.chinaunicom.SUService.SUService")
public class SU implements SUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
