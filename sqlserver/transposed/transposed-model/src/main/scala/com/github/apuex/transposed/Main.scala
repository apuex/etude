package com.github.apuex.transposed

import com.github.apuex.springbootsolution.runtime.TextUtils.indent

object Main extends App {

  def model(modelName: String,
            modelPackage: String,
            dbSchema: String,
            tableName: String
           ): String =
    s"""
       |<?xml version="1.0"?>
       |<!--
       |  Generate wide-column table for history records.
       |  Usage:
       |    java -jar target/scala-2.12/transposed-model-0.1.0.jar <model name> <model package> <db schema> <table name>
       |-->
       |<model name="${modelName}" package="${modelPackage}" dbSchema="${dbSchema}">
       |  <entity name="${tableName}" aggregationRoot="true">
       |    <field no="1" name="battery_id" type="string" length="64" required="true"/>
       |    <field no="2" name="record_time" type="timestamp" required="true"/>
       |    <field no="3" name="battery_current" type="double" required="true"/>
       |    ${indent(dataColumns(4, 24), 4)}
       |    <primaryKey name="${tableName}_pk">
       |      <field name="battery_id"/>
       |      <field name="record_time"/>
       |    </primaryKey>
       |  </entity>
       |</model>
     """.stripMargin.trim

  if(args.length == 3)
    println(model(
      modelName = args(0),
      modelPackage = args(1),
      dbSchema = args(2),
      tableName = args(3)
    ))
  else {
    println(model(
      modelName = "insert_transposed",
      modelPackage = "com.github.xtwxy.insert.transposed",
      dbSchema = "battery_system",
      tableName = "ai_history_minute"
    ))
  }

  def dataColumns(offset: Int, length: Int): String = {
    (offset to (offset + length))
      .map(n => dataColumn(n, s"voltage_${n}"))
      .reduceOption((l, r) => s"${l}\n${r}")
      .getOrElse("")
  }

  def dataColumn(no: Int, name: String): String = {
    s"""
       |<field no="${no}" name="${name}" type="double" required="false"/>
     """.stripMargin.trim
  }
}

