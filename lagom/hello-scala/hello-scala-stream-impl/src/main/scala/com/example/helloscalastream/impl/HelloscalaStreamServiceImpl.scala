package com.example.helloscalastream.impl

import com.lightbend.lagom.scaladsl.api.ServiceCall
import com.example.helloscalastream.api.HelloscalaStreamService
import com.example.helloscala.api.HelloscalaService

import scala.concurrent.Future

/**
  * Implementation of the HelloscalaStreamService.
  */
class HelloscalaStreamServiceImpl(helloscalaService: HelloscalaService) extends HelloscalaStreamService {
  def stream = ServiceCall { hellos =>
    Future.successful(hellos.mapAsync(8)(helloscalaService.hello(_).invoke()))
  }
}
