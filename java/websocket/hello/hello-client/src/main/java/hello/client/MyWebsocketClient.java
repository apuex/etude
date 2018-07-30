package hello.client;

import static java.lang.System.out;

import java.io.IOException;

import javax.websocket.ClientEndpoint;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

import hello.message.Message;
import hello.message.MessageDecoder;
import hello.message.MessageEncoder;

@ClientEndpoint(decoders = MessageDecoder.class, encoders = MessageEncoder.class)
public class MyWebsocketClient {
	
	@OnMessage
	public void onMessage(Message msg, Session session) throws IOException, EncodeException {
		out.println(msg);
		session.getBasicRemote().sendObject(msg);
	}

	@OnOpen
	public void onOpen(Session session) throws IOException, EncodeException {
		out.println(session.isOpen());
		session.getBasicRemote().sendObject(new Message("Wangxy", "Yes!"));
	}

	@OnClose
	public void onClose(Session session) {
		out.println(session.isOpen());
	}

	@OnError
	public void onError(Session session, Throwable t) {
		out.println(session.isOpen());
		t.printStackTrace(out);
	}
	
}
