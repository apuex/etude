package com.example.helloscala.impl

import com.lightbend.lagom.scaladsl.api.ServiceLocator
import com.lightbend.lagom.scaladsl.api.ServiceLocator.NoServiceLocator
import com.lightbend.lagom.scaladsl.persistence.cassandra.CassandraPersistenceComponents
import com.lightbend.lagom.scaladsl.server._
import com.lightbend.lagom.scaladsl.devmode.LagomDevModeComponents
import play.api.libs.ws.ahc.AhcWSComponents
import com.example.helloscala.api.HelloscalaService
import com.lightbend.lagom.scaladsl.broker.kafka.LagomKafkaComponents
import com.lightbend.lagom.scaladsl.playjson.JsonSerializerRegistry
import com.softwaremill.macwire._

class HelloscalaLoader extends LagomApplicationLoader {

  override def load(context: LagomApplicationContext): LagomApplication =
    new HelloscalaApplication(context) {
      override def serviceLocator: ServiceLocator = NoServiceLocator
    }

  override def loadDevMode(context: LagomApplicationContext): LagomApplication =
    new HelloscalaApplication(context) with LagomDevModeComponents

  override def describeService = Some(readDescriptor[HelloscalaService])
}

abstract class HelloscalaApplication(context: LagomApplicationContext)
  extends LagomApplication(context)
    with CassandraPersistenceComponents
    with LagomKafkaComponents
    with AhcWSComponents {

  // Bind the service that this server provides
  override lazy val lagomServer: LagomServer = serverFor[HelloscalaService](wire[HelloscalaServiceImpl])

  // Register the JSON serializer registry
  override lazy val jsonSerializerRegistry: JsonSerializerRegistry = HelloscalaSerializerRegistry

  // Register the hello-scala persistent entity
  persistentEntityRegistry.register(wire[HelloscalaEntity])
}
