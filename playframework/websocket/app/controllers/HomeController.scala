package controllers

import akka.stream.scaladsl.{Flow, Sink, Source}
import javax.inject._
import play.api._
import play.api.mvc._

import scala.concurrent.Future

/**
 * This controller creates an `Action` to handle HTTP requests to the
 * application's home page.
 */
@Singleton
class HomeController @Inject()(cc: ControllerComponents) extends AbstractController(cc) {

  /**
   * Create an Action to render an HTML page.
   *
   * The configuration in the `routes` file means that this method
   * will be called when the application receives a `GET` request with
   * a path of `/`.
   */
  def index(): Action[AnyContent] = Action { implicit request: Request[AnyContent] =>
    Ok(views.html.index())
  }

  def socket: WebSocket = WebSocket.acceptOrResult[String, String] { request =>
    Future.successful(request.session.get("user") match {
      case None => Left(Forbidden)
      case Some(_) =>
        // Log events to the console
        val in = Sink.foreach[String](println)
        // Send a single 'Hello!' message and then leave the socket open
        val out = Source(1 to 1000)
          .map(x => s"Hello, ${x}!")
          .concat(Source.maybe)
        Right(Flow.fromSinkAndSource(in, out))
    })
  }

  def events(offset: Long=1): WebSocket =   WebSocket.accept[String, String] { request =>
    // Log events to the console
    val in = Sink.foreach[String](println)
    // Send a single 'Hello!' message and then leave the socket open
    val out = Source(offset to 1000)
      .map(x => s"Hello, ${x}!")
      .concat(Source.maybe)
    Flow.fromSinkAndSource(in, out)
  }
}
