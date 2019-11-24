package com.github.apuex.akka.websocket.client

import java.util.Date
import java.util.concurrent.TimeUnit

import akka.actor.ActorSystem
import akka.{Done, NotUsed}
import akka.http.scaladsl.Http
import akka.stream.ActorMaterializer
import akka.stream.scaladsl._
import akka.http.scaladsl.model._
import akka.http.scaladsl.model.ws.TextMessage.{Streamed, Strict}
import akka.http.scaladsl.model.ws._

import scala.concurrent.Future
import scala.concurrent.duration.Duration

object Main {
  def main(args: Array[String]) = {
    if(args.length == 1) client(args)
    else usage(args)
  }

  def usage(args: Array[String]) = {
    println(
      s"""
         |Invalid command line option.
         |Example:
         |  java -jar akka-websocket-client.jar "ws://echo.websocket.org"
       """.stripMargin
    )
  }

  def client(args: Array[String]) = {
    implicit val system = ActorSystem()
    implicit val materializer = ActorMaterializer()
    import system.dispatcher

    // print each incoming strict text message
    val printSink: Sink[Message, Future[Done]] =
      Sink.foreach({
        case x: Strict =>
          println(x.text)
        case _ =>
      })

    val duration = Duration.apply(30, TimeUnit.SECONDS)

    val keepAlive = Source.fromIterator(() => new Iterator[TextMessage] {
      override def hasNext: Boolean = true

      override def next(): TextMessage = TextMessage(s"[${new Date()}] - keep-alive.")
    })
      .throttle(1, duration)

    // the Future[Done] is the materialized value of Sink.foreach
    // and it is completed when the stream completes
    val flow: Flow[Message, Message, Future[Done]] =
    Flow.fromSinkAndSourceMat(printSink, keepAlive)(Keep.left)

    // upgradeResponse is a Future[WebSocketUpgradeResponse] that
    // completes or fails when the connection succeeds or fails
    // and closed is a Future[Done] representing the stream completion from above
    val (upgradeResponse, closed) =
    Http().singleWebSocketRequest(WebSocketRequest(args(0)), flow)

    val connected = upgradeResponse.map { upgrade =>
      // just like a regular http request we can access response status which is available via upgrade.response.status
      // status code 101 (Switching Protocols) indicates that server support WebSockets
      if (upgrade.response.status == StatusCodes.SwitchingProtocols) {
        Done
      } else {
        throw new RuntimeException(s"Connection failed: ${upgrade.response.status}")
      }
    }

    // in a real application you would not side effect here
    // and handle errors more carefully
    connected.onComplete(println)
    closed.foreach(_ => println("closed"))
  }
}
