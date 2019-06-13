package com.github.apuex.locc

import scala.io.Source

object Main extends App {

  val add: ((Long, Long), (Long, Long)) => (Long, Long) = { (l, r) =>
    (l._1 + r._1, l._2 + r._2)
  }

  val sum: (Map[String, (Long, Long)], (String, (Long, Long))) => Map[String, (Long, Long)] = { (l, r) =>
    l + (r._1 -> add(l.getOrElse(r._1, (0, 0)), r._2))
  }

  val updates = Source.fromInputStream(System.in)
    .getLines()
    .map(_.split(","))
    .filter(_.length == 3)
    .map(x => (x(2) -> (x(0).toLong, x(1).toLong)))
    .foldLeft(Map[String, (Long, Long)]())(sum)
    .map(x => (x._1, (x._2._1, x._2._2, x._2._1 + x._2._2)))
    .toSeq
    .sortBy(_._1)

  updates.foreach(x => println(s"${x._2._1}\t${x._2._2}\t${x._2._3}\t${x._1}"))

  val total = updates
    .map(_._2)
    .foldLeft((0L, 0L))((l, r) => (l._1 + r._1, l._2 + r._2))

  println(s"lines of code changed: (+${total._1}, -${total._2}) => ${total._1 + total._2}.")
}
