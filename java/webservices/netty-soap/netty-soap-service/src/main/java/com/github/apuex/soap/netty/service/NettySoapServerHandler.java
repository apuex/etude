package com.github.apuex.soap.netty.service;

import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http.*;
import io.netty.util.AsciiString;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;

import static io.netty.handler.codec.http.HttpHeaderNames.*;
import static io.netty.handler.codec.http.HttpHeaderValues.*;
import static io.netty.handler.codec.http.HttpResponseStatus.NO_CONTENT;
import static io.netty.handler.codec.http.HttpResponseStatus.OK;

public class NettySoapServerHandler extends SimpleChannelInboundHandler<HttpObject> {
    private String host =  null;
    private HttpMethod method =  null;
    private String uri =  null;
    private HttpVersion protocolVersion =  null;
    private FullHttpResponse response = null;
    private boolean keepAlive = false;
    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) {
        ctx.flush();
    }

    @Override
    public void channelRead0(ChannelHandlerContext ctx, HttpObject msg) {
        System.out.printf("Request is: %s.\n", msg.getClass().getName());
        if (msg instanceof HttpRequest) {
            HttpRequest req = (HttpRequest) msg;
            System.out.printf("[%s %s %s]\n"
                    , req.method()
                    , req.uri()
                    , req.protocolVersion());
            for (Map.Entry<String, String> e : req.headers()) {
                System.out.printf("\t%s: %s\n", e.getKey(), e.getValue());
            }
            keepAlive = HttpUtil.isKeepAlive(req);
            host = req.headers().get(HOST);
            method = req.method();
            uri = req.uri();
            protocolVersion = req.protocolVersion();
        } else if(msg instanceof HttpContent) {
            HttpContent httpContent = (HttpContent) msg;
            if( uri.equals("/services/FSUService?wsdl")
                && HttpMethod.GET.equals(method)) {
                    handleWsdl(ctx);
            } else if( uri.equals("/services/FSUService?wsdl=1")
                && HttpMethod.GET.equals(method)) {
                    handleInvokeBinding(ctx);
            } else if( uri.equals("/services/FSUService")
                && HttpMethod.POST.equals(method)) {
                    handleInvoke(ctx, httpContent);
            } else {
                response = new DefaultFullHttpResponse(protocolVersion, NO_CONTENT);
            }
            endResponse(ctx);
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        cause.printStackTrace();
        ctx.close();
    }

    private void handleWsdl(ChannelHandlerContext ctx) {
        try {
            final byte[] CONTENT = String.format("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                    "<definitions xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"" +
                    " xmlns:wsp=\"http://www.w3.org/ns/ws-policy\"" +
                    " xmlns:wsp1_2=\"http://schemas.xmlsoap.org/ws/2004/09/policy\"" +
                    " xmlns:wsam=\"http://www.w3.org/2007/05/addressing/metadata\"" +
                    " xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\"" +
                    " xmlns:tns=\"http://SUService.chinaunicom.com/\"" +
                    " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"" +
                    " xmlns=\"http://schemas.xmlsoap.org/wsdl/\"" +
                    " targetNamespace=\"http://SUService.chinaunicom.com/\"" +
                    " name=\"SUService\">\n" +
                    "    <import namespace=\"http://SUService.chinaunicom.com\" location=\"http://%s/services/FSUService?wsdl=1\"></import>\n" +
                    "    <binding xmlns:ns1=\"http://SUService.chinaunicom.com\" name=\"SUPortBinding\" type=\"ns1:SUService\">\n" +
                    "        <soap:binding transport=\"http://schemas.xmlsoap.org/soap/http\" style=\"rpc\"></soap:binding>\n" +
                    "        <operation name=\"invoke\">\n" +
                    "            <soap:operation soapAction=\"\"></soap:operation>\n" +
                    "            <input>\n" +
                    "                <soap:body use=\"literal\" namespace=\"http://SUService.chinaunicom.com\"></soap:body>\n" +
                    "            </input>\n" +
                    "            <output>\n" +
                    "                <soap:body use=\"literal\" namespace=\"http://SUService.chinaunicom.com\"></soap:body>\n" +
                    "            </output>\n" +
                    "        </operation>\n" +
                    "    </binding>\n" +
                    "    <service name=\"SUService\">\n" +
                    "        <port name=\"SUPort\" binding=\"tns:SUPortBinding\">\n" +
                    "            <soap:address location=\"http://%s/services/FSUService\"></soap:address>\n" +
                    "        </port>\n" +
                    "    </service>\n" +
                    "</definitions>", host, host).getBytes(StandardCharsets.UTF_8);
            response = new DefaultFullHttpResponse(protocolVersion, OK,
                    Unpooled.wrappedBuffer(CONTENT));
            response.headers()
                    .set(HttpHeaderNames.DATE, new Date())
                    .set(TRANSFER_ENCODING, HttpHeaderValues.CHUNKED)
                    .set(CONTENT_TYPE, AsciiString.cached("text/xml; charset=utf-8"))
                    .setInt(CONTENT_LENGTH, response.content().readableBytes());

        } catch (Throwable t) {
            throw new RuntimeException(t);
        }
    }

    private void handleInvokeBinding(ChannelHandlerContext ctx) {
        try {
            final byte[] CONTENT = ("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                    "<definitions xmlns:tns=\"http://SUService.chinaunicom.com\"" +
                    " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"" +
                    " xmlns=\"http://schemas.xmlsoap.org/wsdl/\"" +
                    " targetNamespace=\"http://SUService.chinaunicom.com\">\n" +
                    "    <types></types>\n" +
                    "    <message name=\"invoke\">\n" +
                    "        <part name=\"xmlData\" type=\"xsd:string\"></part>\n" +
                    "    </message>\n" +
                    "    <message name=\"invokeResponse\">\n" +
                    "        <part name=\"invokeReturn\" type=\"xsd:string\"></part>\n" +
                    "    </message>\n" +
                    "    <portType name=\"SUService\">\n" +
                    "        <operation name=\"invoke\">\n" +
                    "            <input xmlns:ns1=\"http://www.w3.org/2007/05/addressing/metadata\" ns1:Action=\"http://SUService.chinaunicom.com/SUService/invokeRequest\" message=\"tns:invoke\"></input>\n" +
                    "            <output xmlns:ns2=\"http://www.w3.org/2007/05/addressing/metadata\" ns2:Action=\"http://SUService.chinaunicom.com/SUService/invokeResponse\" message=\"tns:invokeResponse\"></output>\n" +
                    "        </operation>\n" +
                    "    </portType>\n" +
                    "</definitions>").getBytes(StandardCharsets.UTF_8);
            response = new DefaultFullHttpResponse(protocolVersion, OK,
                    Unpooled.wrappedBuffer(CONTENT));
            response.headers()
                    .set(HttpHeaderNames.DATE, new Date())
                    .set(TRANSFER_ENCODING, HttpHeaderValues.CHUNKED)
                    .set(CONTENT_TYPE, AsciiString.cached("text/xml; charset=utf-8"))
                    .setInt(CONTENT_LENGTH, response.content().readableBytes());

        } catch (Throwable t) {
            throw new RuntimeException(t);
        }
    }

    private void handleInvoke(ChannelHandlerContext ctx, HttpContent httpContent) {
        try {
            //byte[] content = new byte[httpContent.content().readableBytes()];
            //httpContent.content().readBytes(content);
            byte[] content = ("<?xml version=\"1.0\" ?><S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"><S:Body>\n" +
                    "<ns2:invokeResponse xmlns:ns2=\"http://SUService.chinaunicom.com\"><invokeReturn>&lt;?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?&gt;&lt;Request&gt;&lt;PK_Type&gt;&lt;Name&gt;GET_FSUINFO&lt;/Name&gt;&lt;/PK_Type&gt;&lt;Info&gt;&lt;FSUID&gt;04201805100002&lt;/FSUID&gt;&lt;/Info&gt;&lt;/Request&gt;&#xD;\n" +
                    "</invokeReturn></ns2:invokeResponse></S:Body></S:Envelope>").getBytes(StandardCharsets.UTF_8);
            response = new DefaultFullHttpResponse(protocolVersion, OK,
                    Unpooled.wrappedBuffer(content));
            response.headers()
                    .set(HttpHeaderNames.DATE, new Date())
                    .set(TRANSFER_ENCODING, HttpHeaderValues.CHUNKED)
                    .set(CONTENT_TYPE, AsciiString.cached("text/xml; charset=utf-8"))
                    .setInt(CONTENT_LENGTH, response.content().readableBytes());

        } catch (Throwable t) {
            throw new RuntimeException(t);
        }
    }

    private void endResponse(ChannelHandlerContext ctx) {
        if (keepAlive) {
            if (!protocolVersion.isKeepAliveDefault()) {
                response.headers().set(CONNECTION, HttpHeaderValues.KEEP_ALIVE);
            }
        } else {
            // Tell the client we're going to close the connection.
            response.headers().set(CONNECTION, CLOSE);
        }

        ChannelFuture f = ctx.write(response);

        if (!keepAlive) {
            f.addListener(ChannelFutureListener.CLOSE);
        }
    }
}
