package com.github.apuex.transposed

import com.github.apuex.springbootsolution.runtime.TextUtils.indent
import com.github.apuex.springbootsolution.runtime.SymbolConverters._

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
       |<model name="${modelName}"
       |       package="${modelPackage}"
       |       dbSchema="${dbSchema}"
       |       journalTable="event_journal">
       |  <entity name="${tableName}" aggregateRoot="true">
       |    <field no="1" name="battery_id" type="string" length="64" required="true" comment="电池组ID"/>
       |    <field no="2" name="record_time" type="timestamp" required="true" comment="记录时间"/>
       |    <field no="3" name="battery_voltage" type="double" required="false" comment="电组组电压"/>
       |    <field no="4" name="battery_current" type="double" required="false" comment="电组组电流"/>
       |    ${indent(dataColumns(5, 24, dataColumn), 4)}
       |    <primaryKey name="${tableName}_pk">
       |      <field name="battery_id"/>
       |      <field name="record_time"/>
       |    </primaryKey>
       |  </entity>
       |  <entity name="event_journal" aggregate="true">
       |    <field name="persistence_id" type="string" length="64" required="true" comment="实体ID" />
       |    <field name="occurred_time" type="timestamp" required="true" comment="事件发生时间" />
       |    <field name="offset" type="long" required="true" comment="事件顺序号"/>
       |    <field name="meta_data" type="string" length="128" required="true" comment="事件元数据" />
       |    <field name="content" type="blob" required="true" comment="事件内容" />
       |    <primaryKey name="event_pk">
       |      <field name="offset" />
       |    </primaryKey>
       |  </entity>
       |</model>
     """.stripMargin.trim

  def accessor(modelName: String,
            modelPackage: String,
            dbSchema: String,
            tableName: String
           ): String =
    s"""
       |object ValueAccessor {
       |
       |  def getValue(obj: ${cToPascal(tableName)}, name: String): Double = name match {
       |    ${indent(dataColumns(5, 24, getter), 4)}
       |  }
       |
       |  def setValue(obj: ${cToPascal(tableName)}, name: String, value: Double): ${cToPascal(tableName)} = name match {
       |    ${indent(dataColumns(5, 24, setter), 4)}
       |  }
       |
       |  def setValues(obj: ${cToPascal(tableName)}, values: Map[String, Double]): ${cToPascal(tableName)} = {
       |    values.foldLeft(obj)((o, v) => setValue(o, v._1, v._2))
       |  }
       |}
     """.stripMargin

  if(args.length == 4) {
    println(model(
      modelName = args(0),
      modelPackage = args(1),
      dbSchema = args(2),
      tableName = args(3)
    ))

    println(accessor(
      modelName = args(0),
      modelPackage = args(1),
      dbSchema = args(2),
      tableName = args(3)
    ))
  } else {
    println(model(
      modelName = "insert_transposed",
      modelPackage = "com.github.xtwxy.insert.transposed",
      dbSchema = "battery_system",
      tableName = "ai_history_minute"
    ))

    println(accessor(
      modelName = "insert_transposed",
      modelPackage = "com.github.xtwxy.insert.transposed",
      dbSchema = "battery_system",
      tableName = "ai_history_minute"
    ))
  }

  def dataColumns(offset: Int = 0, length: Int, dataColumn: (Int, String, Int) => String): String = {
    (offset until (offset + length))
      .map(n => {
        val idx = n - offset + 1
        dataColumn(n, s"voltage", idx)
      })
      .reduceOption((l, r) => s"${l}\n${r}")
      .getOrElse("")
  }

  def dataColumn: (Int, String, Int) => String = { (no, name, idx) =>
    s"""
       |<field no="${no}" name="${name}_${idx}" type="double" required="false" comment="电池单体${idx}电压"/>
     """.stripMargin.trim
  }

  def getter: (Int, String, Int) => String = { (no, name, idx) =>
    s"""
       |case "电池单体${idx}电压" => obj.${cToCamel(name)}${idx}()
     """.stripMargin.trim
  }

  def setter: (Int, String, Int) => String = { (no, name, idx) =>
    s"""
       |case "电池单体${idx}电压" => obj.with${cToPascal(name)}${idx}(value)
     """.stripMargin.trim
  }
}

