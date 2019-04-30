package hello.client;

import javax.websocket.*;
import java.io.IOException;

import static java.lang.System.out;

@ClientEndpoint()
public class MyWebsocketClient {

  @OnMessage
  public void onMessage(String msg, Session session) throws IOException, EncodeException {
    out.println(msg);
  }

  @OnOpen
  public void onOpen(Session session) throws IOException, EncodeException {
    out.println(session.isOpen());
    session.getBasicRemote().sendObject(String.format("%s, %s", System.getProperty("user.name"), System.getProperty("java.vm.name")));
  }

  @OnClose
  public void onClose(Session session) throws Exception {
    out.println("onClose: " + session.isOpen());
    System.exit(0);
  }

  @OnError
  public void onError(Session session, Throwable t) {
    out.println("onError: " + session.isOpen());
    t.printStackTrace(out);
  }

}
