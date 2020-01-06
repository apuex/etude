package com.github.apuex.java.webservice;

import javax.jws.WebService;
import javax.xml.ws.BindingType;
import java.util.Date;

@WebService(endpointInterface = "com.github.apuex.java.webservice.TimeServer")
@BindingType(javax.xml.ws.soap.SOAPBinding.SOAP12HTTP_BINDING)
public class TimeServerImpl implements TimeServer {
    @Override
    public String getTimeAsString() {
        return new Date().toString();
    }

    @Override
    public long getTimeAsElapsed() {
        return new Date().getTime();
    }
}
