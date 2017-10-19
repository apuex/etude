package com.apuex.messages

import com.apuex.common.Command


final case class Device (
  deviceId: String,
  deviceName: String,
  vendor: String,
  vendorModel: String,
  signals: Array[Signal],
  params: Map[String, String]
) extends Command

