package com.github.apuex.jms;

import com.google.protobuf.Message;

import java.util.LinkedList;
import java.util.Queue;

import static java.lang.System.out;

public class ProtobufMessageListenerDelegate {
  private final Queue<Message> messages = new LinkedList<>();
  private boolean discard = true;

  public void handleMessage(Message m) {
    out.println(m);
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
      return messages.remove();
    }
  }

  public void setDiscard(boolean discard) {
    this.discard = discard;
  }
}
