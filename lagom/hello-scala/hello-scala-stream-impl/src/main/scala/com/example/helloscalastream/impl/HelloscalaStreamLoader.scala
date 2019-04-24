package com.example.helloscalastream.impl

import com.lightbend.lagom.scaladsl.api.ServiceLocator.NoServiceLocator
import com.lightbend.lagom.scaladsl.server._
import com.lightbend.lagom.scaladsl.devmode.LagomDevModeComponents
import play.api.libs.ws.ahc.AhcWSComponents
import com.example.helloscalastream.api.HelloscalaStreamService
import com.example.helloscala.api.HelloscalaService
import com.softwaremill.macwire._

class HelloscalaStreamLoader extends LagomApplicationLoader {

  override def load(context: LagomApplicationContext): LagomApplication =
    new HelloscalaStreamApplication(context) {
      override def serviceLocator: NoServiceLocator.type = NoServiceLocator
    }

  override def loadDevMode(context: LagomApplicationContext): LagomApplication =
    new HelloscalaStreamApplication(context) with LagomDevModeComponents

  override def describeService = Some(readDescriptor[HelloscalaStreamService])
}

abstract class HelloscalaStreamApplication(context: LagomApplicationContext)
  extends LagomApplication(context)
    with AhcWSComponents {

  // Bind the service that this server provides
  override lazy val lagomServer: LagomServer = serverFor[HelloscalaStreamService](wire[HelloscalaStreamServiceImpl])

  // Bind the HelloscalaService client
  lazy val helloscalaService: HelloscalaService = serviceClient.implement[HelloscalaService]
}
