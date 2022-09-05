package com.chinaunicom.SUService;

import javax.jws.WebService;
import javax.xml.ws.BindingType;
import javax.xml.ws.soap.SOAPBinding;

@WebService(endpointInterface = "com.chinaunicom.SUService.SUService")
@BindingType(SOAPBinding.SOAP11HTTP_BINDING)
public class SU implements SUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
