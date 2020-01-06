package com.chinaunicom.SCService;

import javax.jws.WebService;
import javax.xml.ws.BindingType;

@WebService(endpointInterface = "com.chinaunicom.SCService.SCService")
@BindingType(javax.xml.ws.soap.SOAPBinding.SOAP12HTTP_BINDING)
public class SC implements SCService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
