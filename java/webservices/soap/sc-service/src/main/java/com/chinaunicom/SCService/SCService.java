package com.chinaunicom.SCService;

import javax.jws.WebService;
import javax.xml.ws.BindingType;
import javax.xml.ws.soap.SOAPBinding;

@WebService(endpointInterface = "com.chinaunicom.SCService.ISCService")
@BindingType(SOAPBinding.SOAP11HTTP_BINDING)
public class SCService implements ISCService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
