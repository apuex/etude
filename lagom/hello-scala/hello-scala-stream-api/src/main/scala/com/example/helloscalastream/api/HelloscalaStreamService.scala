package com.example.helloscalastream.api

import akka.NotUsed
import akka.stream.scaladsl.Source
import com.lightbend.lagom.scaladsl.api.{Descriptor, Service, ServiceCall}

/**
  * The hello-scala stream interface.
  *
  * This describes everything that Lagom needs to know about how to serve and
  * consume the HelloscalaStream service.
  */
trait HelloscalaStreamService extends Service {

  def stream: ServiceCall[Source[String, NotUsed], Source[String, NotUsed]]

  override final def descriptor: Descriptor = {
    import Service._

    named("hello-scala-stream")
      .withCalls(
        namedCall("stream", stream)
      ).withAutoAcl(true)
  }
}

