package hello.server;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import hello.message.Message;
import hello.message.MessageDecoder;
import hello.message.MessageEncoder;

@ServerEndpoint(value="/hello", decoders=MessageDecoder.class, encoders=MessageEncoder.class)
public class MyHelloServer {
	@OnOpen
	public void onOpen(Session session) {
		
	}

	@OnMessage
	public Message handleMessage(Message message, Session session) {
		return message;
	}

	@OnClose
	public void onClose(Session session) {

	}

	@OnError
	public void onError(Session session, Throwable t) {
	}
}
