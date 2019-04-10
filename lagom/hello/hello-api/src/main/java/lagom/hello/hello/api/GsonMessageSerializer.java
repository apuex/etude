package lagom.hello.hello.api;

import com.google.protobuf.InvalidProtocolBufferException;
import com.google.protobuf.Message;
import com.google.protobuf.MessageOrBuilder;
import com.google.protobuf.util.JsonFormat;
import com.lightbend.lagom.javadsl.api.deser.DeserializationException;
import com.lightbend.lagom.javadsl.api.deser.MessageSerializer;
import com.lightbend.lagom.javadsl.api.deser.SerializationException;
import com.lightbend.lagom.javadsl.api.transport.MessageProtocol;
import com.lightbend.lagom.javadsl.api.transport.NotAcceptable;
import com.lightbend.lagom.javadsl.api.transport.UnsupportedMediaType;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

public class GsonMessageSerializer<T> implements MessageSerializer<T, akka.util.ByteString> {
  private final MessageProtocol protocol;
  private final Class<T> clazz;
  private Method builderMethod = null;
  private final JsonFormat.Parser parser;
  private final JsonFormat.Printer printer;

  public GsonMessageSerializer(Class<T> clazz, JsonFormat.TypeRegistry registry) {
    this.clazz = clazz;
    try {
      this.builderMethod = clazz.getDeclaredMethod("newBuilder");
    } catch (NoSuchMethodException e) {
      throw new RuntimeException(e);
    }
    this.protocol = new MessageProtocol(Optional.of("application/json"), Optional.of("utf-8"), Optional.of("1.0.0"));
    this.parser = JsonFormat.parser().usingTypeRegistry(registry);
    this.printer = JsonFormat.printer().usingTypeRegistry(registry);
  }

  @Override
  public NegotiatedSerializer<T, akka.util.ByteString> serializerForRequest() {
    return new GsonSerializer();
  }

  @Override
  public NegotiatedDeserializer<T, akka.util.ByteString> deserializer(MessageProtocol protocol) throws UnsupportedMediaType {
    return new GsonDeserializer();
  }

  @Override
  public NegotiatedSerializer<T, akka.util.ByteString> serializerForResponse(List<MessageProtocol> acceptedMessageProtocols) throws NotAcceptable {
    return new GsonSerializer();
  }

  private class GsonSerializer implements NegotiatedSerializer<T, akka.util.ByteString> {
    @Override
    public MessageProtocol protocol() {
      return protocol;
    }

    @Override
    public akka.util.ByteString serialize(T messageOrBuilder) throws SerializationException {
      try {
        return akka.util.ByteString.fromString(printer.print((MessageOrBuilder) messageOrBuilder), StandardCharsets.UTF_8);
      } catch (InvalidProtocolBufferException e) {
        throw new SerializationException(e);
      }
    }
  }

  private Message.Builder newBuilder() {
    try {
      Object builder = builderMethod.invoke(null);
      return (Message.Builder)builder;
    } catch (IllegalAccessException | InvocationTargetException e) {
      throw new RuntimeException(e);
    }
  }

  private class GsonDeserializer implements NegotiatedDeserializer<T, akka.util.ByteString> {

    @Override
    public T deserialize(akka.util.ByteString wire) throws DeserializationException {
      try {
        Message.Builder builder = newBuilder();
        parser.merge(wire.utf8String(), builder);
        return (T) builder.build();
      } catch (InvalidProtocolBufferException e) {
        throw new DeserializationException(e);
      }
    }
  }
}
