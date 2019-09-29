ThisBuild / scalaVersion     := "2.12.8"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "com.example"
ThisBuild / organizationName := "example"

enablePlugins(ScalaJSPlugin)
scalaJSUseMainModuleInitializer := true
jsEnv := new org.scalajs.jsenv.jsdomnodejs.JSDOMNodeJSEnv()
skip in packageJSDependencies := false

lazy val root = (project in file("."))
  .settings(
    name := "hello",
    libraryDependencies ++= Seq(
      "org.scala-js" %%% "scalajs-dom" % "0.9.7",
      "org.querki" %%% "jquery-facade" % "1.2",
      "org.webjars" % "jquery" % "2.2.1" / "jquery.js" minified "jquery.min.js",
      "org.scalatest" %% "scalatest" % "3.0.8"
    )
  )

// See https://www.scala-sbt.org/1.x/docs/Using-Sonatype.html for instructions on how to publish to Sonatype.
