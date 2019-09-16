import Dependencies._

ThisBuild / scalaVersion     := "2.12.8"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "com.github.apuex"
ThisBuild / organizationName := "apuex"

lazy val root = (project in file("."))
  .settings(
    name := "transposed-model",
    libraryDependencies ++= Seq(
      sbsUtil,
      scalaTest % Test
    )
  )

// See https://www.scala-sbt.org/1.x/docs/Using-Sonatype.html for instructions on how to publish to Sonatype.
assemblyMergeStrategy in assembly := {
  case PathList("META-INF", "io.netty.versions.properties") => MergeStrategy.rename
  case x =>
    val oldStrategy = (assemblyMergeStrategy in assembly).value
    oldStrategy(x)
}

mainClass in assembly := Some(s"${organization.value}.transposed.Main")
assemblyJarName in assembly := s"${name.value}-${version.value}.jar"