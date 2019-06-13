name := "loc-changes"
scalaVersion := "2.12.8"
organization := "com.github.apuex"
version      := "1.0.0"
maintainer   := "xtwxy@hotmail.com"

lazy val root = (project in file("."))
  .enablePlugins(GraalVMNativeImagePlugin)

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "3.0.7" % Test
)

graalVMNativeImageOptions ++= Seq(
  "-H:+ReportUnsupportedElementsAtRuntime",
  "-H:IncludeResources=.*conf",
  "-H:IncludeResources=.*\\.properties",
  "-H:IncludeResources=.*\\.xml",
  "-H:IncludeResourceBundles=com.sun.org.apache.xerces.internal.impl.msg.XMLMessages",
  "-H:ReflectionConfigurationFiles=" + baseDirectory.value / "graal" / "reflection-xml.json"
)

assemblyMergeStrategy in assembly := {
  case PathList("META-INF", "io.netty.versions.properties") => MergeStrategy.rename
  case x =>
    val oldStrategy = (assemblyMergeStrategy in assembly).value
    oldStrategy(x)
}

mainClass in assembly := Some(s"${organization.value}.locc.Main")
assemblyJarName in assembly := s"${name.value}-${version.value}.jar"
