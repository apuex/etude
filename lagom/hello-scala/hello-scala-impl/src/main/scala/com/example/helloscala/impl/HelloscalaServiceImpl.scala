package com.example.helloscala.impl

import com.example.helloscala.api
import com.example.helloscala.api.HelloscalaService
import com.lightbend.lagom.scaladsl.api.ServiceCall
import com.lightbend.lagom.scaladsl.api.broker.Topic
import com.lightbend.lagom.scaladsl.broker.TopicProducer
import com.lightbend.lagom.scaladsl.persistence.{EventStreamElement, PersistentEntityRegistry}

/**
  * Implementation of the HelloscalaService.
  */
class HelloscalaServiceImpl(persistentEntityRegistry: PersistentEntityRegistry) extends HelloscalaService {

  override def hello(id: String) = ServiceCall { _ =>
    // Look up the hello-scala entity for the given ID.
    val ref = persistentEntityRegistry.refFor[HelloscalaEntity](id)

    // Ask the entity the Hello command.
    ref.ask(Hello(id))
  }

  override def useGreeting(id: String) = ServiceCall { request =>
    // Look up the hello-scala entity for the given ID.
    val ref = persistentEntityRegistry.refFor[HelloscalaEntity](id)

    // Tell the entity to use the greeting message specified.
    ref.ask(UseGreetingMessage(request.message))
  }


  override def greetingsTopic(): Topic[api.GreetingMessageChanged] =
    TopicProducer.singleStreamWithOffset {
      fromOffset =>
        persistentEntityRegistry.eventStream(HelloscalaEvent.Tag, fromOffset)
          .map(ev => (convertEvent(ev), ev.offset))
    }

  private def convertEvent(helloEvent: EventStreamElement[HelloscalaEvent]): api.GreetingMessageChanged = {
    helloEvent.event match {
      case GreetingMessageChanged(msg) => api.GreetingMessageChanged(helloEvent.entityId, msg)
    }
  }
}
