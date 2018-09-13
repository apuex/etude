package com.github.apuex.jms;

import com.sun.messaging.ConnectionFactory;

import javax.jms.JMSException;
import java.util.Properties;

public class SunConnectionFactory extends ConnectionFactory {
  public SunConnectionFactory () {

  }

  protected SunConnectionFactory(String name) {
    super(name);
  }

  public void setConfiguration(Properties configuration) {
    configuration.entrySet().forEach(e -> {
      getConfiguration().setProperty((String)e.getKey(), (String)e.getValue());
    });
  }
}
