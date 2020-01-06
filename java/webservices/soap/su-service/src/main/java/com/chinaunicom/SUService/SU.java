package com.chinaunicom.SUService;

import javax.jws.WebService;
import javax.xml.ws.BindingType;

@WebService(endpointInterface = "com.chinaunicom.SUService.SUService")
@BindingType(javax.xml.ws.soap.SOAPBinding.SOAP12HTTP_BINDING)
public class SU implements SUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
