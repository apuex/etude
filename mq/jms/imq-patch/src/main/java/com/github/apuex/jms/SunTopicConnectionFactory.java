package com.github.apuex.jms;


import javax.jms.TopicConnectionFactory;

public class SunTopicConnectionFactory extends SunConnectionFactory implements TopicConnectionFactory {
  public SunTopicConnectionFactory() {
  }

  protected SunTopicConnectionFactory(String name) {
    super(name);
  }
}