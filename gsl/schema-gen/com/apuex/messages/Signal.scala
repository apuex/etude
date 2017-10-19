package com.apuex.messages

import com.apuex.common.Command


final case class Signal (
  signalId: String,
  signalName: String
) extends Command
