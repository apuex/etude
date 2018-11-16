package com.github.apuex.akka.stream.jms

import java.nio.ByteBuffer
import java.util.UUID

import akka.actor.ActorSystem
import akka.stream.alpakka.cassandra.scaladsl.CassandraSink
import akka.stream.alpakka.jms.JmsConsumerSettings
import akka.stream.{ActorMaterializer, KillSwitch}
import akka.stream.alpakka.jms.scaladsl.JmsConsumer
import akka.stream.scaladsl.{Keep, Sink, Source}
import com.datastax.driver.core.{Cluster, PreparedStatement}
import com.sun.messaging.QueueConnectionFactory
import javax.jms.{BytesMessage, Message}
import java.util.UUID.randomUUID

object Main extends App {
  val parallelize = 8
  implicit val system = ActorSystem()
  implicit val mat = ActorMaterializer()

  // cassandra session
  implicit val session = Cluster.builder
    .addContactPoint("127.0.0.1")
    .withPort(9042)
    .build
    .connect()

  val insertStatement = session.prepare(s"INSERT INTO test(id, v) VALUES (?, ?)")
  val insertStatementBinder = (l: (UUID, ByteBuffer), statement: PreparedStatement) => {
    statement.bind()
      .setString(0, l._1.toString)
      .setBytes(1, l._2)
  }
  val insertSink = CassandraSink[(UUID, ByteBuffer)](parallelize, insertStatement, insertStatementBinder)

  // jms queue
  val connectionFactory = new QueueConnectionFactory()
  connectionFactory.setProperty("imqBrokerHostName", "127.0.0.1")
  connectionFactory.setProperty("imqBrokerHostPort", "7676")
  connectionFactory.setProperty("imqDefaultUsername", "admin")
  connectionFactory.setProperty("imqDefaultPassword", "admin")
  connectionFactory.setProperty("imqReconnectEnabled", "true")
  connectionFactory.setProperty("imqReconnectInterval", "3000")
  connectionFactory.setProperty("imqReconnectAttempts", "1000000")

  val jmsSource: Source[Message, KillSwitch] = JmsConsumer(
    JmsConsumerSettings(connectionFactory)
      .withQueue("test")
      .withSessionCount(parallelize)
  )

  jmsSource
    .map {
      case m: BytesMessage =>
        val byteArray = new Array[Byte](m.getBodyLength.toInt)
        m.readBytes(byteArray)
        (randomUUID(), ByteBuffer.wrap(byteArray))
      case _ =>
        (randomUUID(), ByteBuffer.wrap(new Array[Byte](0)))
    }
    .toMat(insertSink)(Keep.left).run()(mat)
    //.runWith(Sink.seq)
}
