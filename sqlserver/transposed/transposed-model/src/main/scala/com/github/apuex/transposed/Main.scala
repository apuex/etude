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
       |<model name="${modelName}"
       |       package="${modelPackage}"
       |       dbSchema="${dbSchema}"
       |       journalTable="event_journal">
       |  <entity name="${tableName}" aggregateRoot="true">
       |    <field no="1" name="battery_id" type="string" length="64" required="true" comment="电池组ID"/>
       |    <field no="2" name="record_time" type="timestamp" required="true" comment="记录时间"/>
       |    <field no="3" name="battery_current" type="double" required="true" comment="电组组电流"/>
       |    ${indent(dataColumns(4, 24), 4)}
       |    <primaryKey name="${tableName}_pk">
       |      <field name="battery_id"/>
       |      <field name="record_time"/>
       |    </primaryKey>
       |  </entity>
       |   <entity name="event_journal" aggregate="true">
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

  if(args.length == 4)
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

  def dataColumns(offset: Int = 0, length: Int): String = {
    (offset until (offset + length))
      .map(n => dataColumn(n, s"voltage_${n - offset + 1}"))
      .reduceOption((l, r) => s"${l}\n${r}")
      .getOrElse("")
  }

  def dataColumn(no: Int, name: String, offset: Int = 0): String = {
    s"""
       |<field no="${no}" name="${name}" type="double" required="false" comment="电池单体${no - offset + 1}电压"/>
     """.stripMargin.trim
  }
}

