package com.github.apuex.locc

import java.io.{FileInputStream, InputStream}

import scala.io.Source

/**
  * Calculate LOC(lines of code) changed via `git log`.
  *
  * package it to a runnable jar, or AOT-compile to native image ^_^
  *
  * Usage:
  *
  *  `git log --numstat -- .| grep -i ^[0-9] | awk '{print $1 "," $2 "," $3}' | java -jar loc-changes.jar`
  *
  * for runnable jar, or:
  *
  *  `git log --numstat -- .| grep -i ^[0-9] | awk '{print $1 "," $2 "," $3}' | ./loc-changes`
  *
  *  for native image.
  */
object Main extends App {
  val usage: () => String = { () =>
    s"""
       |Usage:
       |    <cmd> <[summary] | [per-files]> <input file name>
       |  where:
       |    <cmd>             => `java -jar locc.jar`
       |                         for runnable jar, or:
       |                         `./locc`
       |                         for native image.
       |    summary           => print summary.
       |    per-files         => print by per-file.
       |    <input file name> => optional input file name. stdin is used if omitted.
       |Example:
       |    `git log --numstat -- . | grep -i ^[0-9] | awk '{print $$1 "," $$2 "," $$3}' | grep -P '(java|scala|sbt|xml|properties)$$' | java -jar loc-changes.jar summary`
       |  for runnable jar, or:
       |    `git log --numstat -- . | grep -i ^[0-9] | awk '{print $$1 "," $$2 "," $$3}' | grep -P '(java|scala|sbt|xml|properties)$$' | ./loc-changes summary`
       |  for native image.
     """.stripMargin.trim
  }

  val add: ((Long, Long), (Long, Long)) => (Long, Long) = { (l, r) =>
    (l._1 + r._1, l._2 + r._2)
  }

  val sum: (Map[String, (Long, Long)], (String, (Long, Long))) => Map[String, (Long, Long)] = { (l, r) =>
    l + (r._1 -> add(l.getOrElse(r._1, (0, 0)), r._2))
  }

  val calculate: (String, InputStream) => Unit = { (option, in) =>
    val updates = Source.fromInputStream(in)
      .getLines()
      .map(_.split(","))
      .filter(_.length == 3) // just in case...
      .map(x => (x(2) -> (x(0).toLong, x(1).toLong)))
      .foldLeft(Map[String, (Long, Long)]())(sum)
      .map(x => (x._1, (x._2._1, x._2._2)))
      .map(x => {
        if(x._2._1 < x._2._2) println(System.err, s"${x._2._1}\t${x._2._2}\t${x._2._1 + x._2._2}\t${x._1}")
        x
      })
      .toSeq
      .sortBy(_._1)

    if ("per-file" == option) {
      updates.foreach(x => println(s"${x._2._1}\t${x._2._2}\t${x._2._1 + x._2._2}\t${x._1}"))
    } else {
      val total = updates
        .map(_._2)
        .foldLeft((0L, 0L))((l, r) => (l._1 + r._1, l._2 + r._2))

      val net = (total._1 - total._2)

      println("Summary of LOC changed:")
      print(s"(+${total._1}, -${total._2}) => ${net} lines yield, ")
      println(s"${if (total._1 == 0) "n/a" else "%.2f%%".format(net * 100.0/ total._1)} ratio.")
    }
  }

  if(args.length == 1) calculate(args(0), System.in)
  else if(args.length == 2) calculate(args(0), new FileInputStream(args(1)))
  else println(usage())
}
