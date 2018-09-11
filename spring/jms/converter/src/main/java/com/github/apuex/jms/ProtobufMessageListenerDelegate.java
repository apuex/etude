package com.github.apuex.jms;

import com.google.protobuf.Message;

public class ProtobufMessageListenerDelegate {

  public void handleMessage(Greetings message) {
    System.out.printf("Supposed to be Greetings: %s\n", message);
  }

  public void handleMessage(Gentlemen message) {
    System.out.printf("Supposed to be Gentlemen: %s\n", message);
  }

  public void handleMessage(Message message) {
    System.out.printf("Supposed to be Message: %s\n", message);
  }
}
