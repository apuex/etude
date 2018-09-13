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
import java.util.ArrayList;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
@ActiveProfiles("dev")
public class MultipleMessageHandlerTest {
  @Autowired
  private MultipleMessageHandler handler;
  @Autowired
  private JmsTemplate template;

  @Test
  public void testToMessage() throws Exception {
    ArrayList<com.google.protobuf.Message> al = new ArrayList<>();
    al.add(Greetings.newBuilder().setName("me").build());
    al.add(Gentlemen.newBuilder().setName("me").build());
    template.send(session -> {
      Message message = template.getMessageConverter().toMessage(al.get(0), session);
      Assert.assertNotNull(message);
      return message;
    });
    template.send(session -> {
      Message message = template.getMessageConverter().toMessage(al.get(1), session);
      Assert.assertNotNull(message);
      return message;
    });
    Assert.assertEquals(al.get(0), handler.pop());
    Assert.assertEquals(al.get(1), handler.pop());
  }

}
