package com.github.apuex.locc

import scala.io.Source

/**
  * Calculate LOC(lines of code) changed via `git log`.
  *
  * package it to a runnable jar, or AOT-compile to native image ^_^
  *
  * Usage:
  *
  *   `git log --numstat | grep -i ^[0-9] | awk '{print $1 "," $2 "," $3}' | java -jar locc.jar`
  *
  * for runnable jar, or:
  *
  *  `git log --numstat | grep -i ^[0-9] | awk '{print $1 "," $2 "," $3}' | ./locc`
  *
  *  for native image.
  */
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
    .filter(_.length == 3)  // just in case...
    .map(x => (x(2) -> (x(0).toLong, x(1).toLong)))
    .foldLeft(Map[String, (Long, Long)]())(sum)
    .map(x => (x._1, (x._2._1, x._2._2)))
    .toSeq
    .sortBy(_._1)

  updates.foreach(x => println(s"${x._2._1}\t${x._2._2}\t${x._2._1 + x._2._2}\t${x._1}"))

  val total = updates
    .map(_._2)
    .foldLeft((0L, 0L))((l, r) => (l._1 + r._1, l._2 + r._2))

  val net = (total._1 - total._2)
  println(
    s"""
       |Summary of LOC changed:
       |  (+${total._1}, -${total._2}) => ${net}) yield.
       |  ${if(total._1 == 0) "n/a" else (net / total._1)} ratio.
     """.stripMargin.trim)
}
