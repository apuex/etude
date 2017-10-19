lazy val akkaVersion = "2.5.3"
lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "apuex",
      scalaVersion := "2.12.3",
      version      := "1.0.0"
    )),
    name := "simple-cluster",
    libraryDependencies ++= Seq(
      "com.typesafe.akka" %% "akka-testkit" % akkaVersion,
      "org.scalatest" %% "scalatest" % "3.0.1" % "test"
    )
  )
  .aggregate(
    app_config,
    dummy_launcher
  )

lazy val app_config = (project in file("app-config"))
lazy val dummy_launcher = (project in file("dummy-launcher")).dependsOn(app_config)


