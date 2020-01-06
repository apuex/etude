package com.chinamobile.FSUService;

import javax.jws.WebService;
import javax.xml.ws.BindingType;

@WebService(endpointInterface = "com.chinamobile.FSUService.FSUService")
@BindingType(javax.xml.ws.soap.SOAPBinding.SOAP12HTTP_BINDING)
public class FSU implements FSUService {

    @Override
    public String invoke(String xmlData) {
        return xmlData;
    }
}
