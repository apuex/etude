package com.github.apuex.jms;

import com.google.protobuf.Message;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.Queue;

import static java.lang.System.out;

@Component
public class MultipleMessageHandler {
  private final Queue<Message> messages = new LinkedList<>();
  private boolean discard = true;

  @JmsListener(destination = "EVENT_NOTIFY_TOPIC", containerFactory="jmsMessageListenerContainer")
  public void handleMessage(Message m) {
    out.printf("%s: %s\n", m.getClass().getName(), m);
    if(!discard)
    synchronized (this) {
      messages.add(m);
      this.notify();
    }
  }

  public Message pop() throws InterruptedException {
    synchronized (this) {
      if (messages.isEmpty()) {
        this.wait(5000);
      }
      return messages.poll();
    }
  }

  public void setDiscard(boolean discard) {
    this.discard = discard;
  }
}
