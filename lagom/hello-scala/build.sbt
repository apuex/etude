organization in ThisBuild := "com.example"
version in ThisBuild := "1.0.0"
maintainer := "xtwxy@hotmail.com"

// the Scala version that will be used for cross-compiled libraries
scalaVersion in ThisBuild := "2.12.8"

val macwire = "com.softwaremill.macwire" %% "macros" % "2.3.0" % "provided"
val scalaTest = "org.scalatest" %% "scalatest" % "3.0.4" % Test

lazy val `hello-scala` = (project in file("."))
  .aggregate(`hello-scala-api`, `hello-scala-impl`, `hello-scala-stream-api`, `hello-scala-stream-impl`)

lazy val `hello-scala-api` = (project in file("hello-scala-api"))
  .settings(
    maintainer := "xtwxy@hotmail.com",
    libraryDependencies ++= Seq(
      lagomScaladslApi
    )
  )

lazy val `hello-scala-impl` = (project in file("hello-scala-impl"))
  .enablePlugins(LagomScala)
  .settings(
    maintainer := "xtwxy@hotmail.com",
    libraryDependencies ++= Seq(
      lagomScaladslPersistenceCassandra,
      lagomScaladslKafkaBroker,
      lagomScaladslTestKit,
      macwire,
      scalaTest
    )
  )
  .settings(lagomForkedTestSettings)
  .dependsOn(`hello-scala-api`)

lazy val `hello-scala-stream-api` = (project in file("hello-scala-stream-api"))
  .settings(
    maintainer := "xtwxy@hotmail.com",
    libraryDependencies ++= Seq(
      lagomScaladslApi
    )
  )

lazy val `hello-scala-stream-impl` = (project in file("hello-scala-stream-impl"))
  .enablePlugins(LagomScala)
  .settings(
    maintainer := "xtwxy@hotmail.com",
    libraryDependencies ++= Seq(
      lagomScaladslTestKit,
      macwire,
      scalaTest
    )
  )
  .dependsOn(`hello-scala-stream-api`, `hello-scala-api`)
