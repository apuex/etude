package hello.message;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import com.google.gson.Gson;

public class MessageEncoder implements Encoder.Text<Message> {

	private static Gson gson = new Gson();
	
	@Override
	public void init(EndpointConfig config) {
		
	}

	@Override
	public void destroy() {
		
	}

	@Override
	public String encode(Message msg) throws EncodeException {
		return gson.toJson(msg);
	}

}
