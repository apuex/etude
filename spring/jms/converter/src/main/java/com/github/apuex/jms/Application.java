package com.github.apuex.jms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.jms.annotation.EnableJms;

@Configuration
@ComponentScan({"com.github.apuex.jms.*"})
@ImportResource("classpath:app-config.xml")
@SpringBootApplication
@EnableJms
public class Application {

  public static void main(String[] args) {
    // Launch the application
    ConfigurableApplicationContext context = SpringApplication.run(Application.class, args);

  }
}

