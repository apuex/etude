package com.github.apuex.jms;


import javax.jms.QueueConnectionFactory;

public class SunQueueConnectionFactory extends SunConnectionFactory implements QueueConnectionFactory {
  public SunQueueConnectionFactory() {
  }

  protected SunQueueConnectionFactory(String name) {
    super(name);
  }
}