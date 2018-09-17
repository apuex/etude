package com.github.apuex.jms;

import com.github.apuex.eventsource.jms.EventSourceJmsAdapter;
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

    MultipleMessageHandler multipleMessageHandler = context.getBean(MultipleMessageHandler.class);
    EventSourceJmsAdapter eventSourceAdapter = context.getBean(EventSourceJmsAdapter.class);

    // Publish a message with a POJO
    // reuse the message converter
    System.out.println("sending greetings...");
    Greetings greetings = Greetings.newBuilder()
        .setName("Hello, World!")
        .build();
    System.out.println(greetings);
    Gentlemen gentlemen = Gentlemen.newBuilder()
        .setName("Hello, Ladies!")
        .build();
    System.out.println(gentlemen);

    eventSourceAdapter.publish(greetings);
    eventSourceAdapter.publish(gentlemen);

    System.out.println("greetings sent.");
  }
}

