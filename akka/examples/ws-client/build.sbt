name := "akka-websocket-client"
scalaVersion := "2.12.8"
organization := "com.github.apuex"
version      := "1.0.0"
maintainer   := "xtwxy@hotmail.com"

lazy val table = (project in file("."))
  .enablePlugins(GraalVMNativeImagePlugin)

libraryDependencies ++= Seq(
  "com.typesafe.akka" %% "akka-http"   % "10.1.8", 
  "com.typesafe.akka" %% "akka-stream" % "2.5.19" // or whatever the latest version is
)

lazy val localRepo = Some(Resolver.file("file",  new File(Path.userHome.absolutePath+"/.m2/repository")))
publishTo := localRepo

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

mainClass in assembly := Some(s"${organization.value}.akka.websocket.client.Main")
assemblyJarName in assembly := s"${name.value}-${version.value}.jar"
