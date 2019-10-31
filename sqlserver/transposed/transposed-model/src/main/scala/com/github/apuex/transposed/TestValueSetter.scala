package com.github.apuex.transposed

class TestValueSetter extends ValueSetter[TestObject, String, Double] {
  override def setValue(obj: TestObject, name: String, value: Double): TestObject = name match {
    case "0" => obj.value1(value)
  }

  def setValues(obj: TestObject, values: Map[String, Double]): TestObject = {
    values.foldLeft(obj)((o, v) => setValue(o, v._1, v._2))
  }
}
