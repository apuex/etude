package hello.client;

import java.net.URI;

import javax.websocket.ContainerProvider;
import javax.websocket.WebSocketContainer;

public class Main {

	public static void main(String[] args) throws Exception {
		WebSocketContainer container = ContainerProvider.getWebSocketContainer();
		container.connectToServer(MyWebsocketClient.class, URI.create(args[0]));
	}

}
