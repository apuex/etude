package com.github.apuex.jms;

import com.sun.messaging.XAConnectionFactory;

import java.util.Properties;

public class SunXAConnectionFactory extends XAConnectionFactory {
  public SunXAConnectionFactory() {

  }

  public void setConfiguration(Properties configuration) {
    configuration.entrySet().forEach(e -> {
      getConfiguration().setProperty((String)e.getKey(), (String)e.getValue());
    });
  }
}
