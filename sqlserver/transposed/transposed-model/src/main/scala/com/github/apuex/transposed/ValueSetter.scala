package com.github.apuex.transposed

trait ValueSetter[O, N, V] {
  def setValue(obj: O, name: N, value: V): O
}
