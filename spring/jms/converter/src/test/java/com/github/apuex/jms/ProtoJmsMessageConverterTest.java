package com.github.apuex.jms;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.jms.Message;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
@ActiveProfiles("dev")
public class ProtoJmsMessageConverterTest {
  @Autowired
  ProtobufMessageListenerDelegate delegate;
  @Autowired
  private JmsTemplate template;

  @Test
  public void testToMessage() throws Exception {
    Greetings payload = Greetings.newBuilder()
        .setName("me")
        .build();

    template.send(session -> {
      Message message = template.getMessageConverter().toMessage(payload, session);
      Assert.assertNotNull(message);

      return message;
    });
  }

  @Test
  public void testFromMessage() throws Exception {

    Greetings payload = Greetings.newBuilder()
        .setName("me")
        .build();

    Greetings expected = (Greetings) delegate.pop();
    Assert.assertEquals(expected, payload);
  }
}
