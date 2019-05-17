#! /bin/bash

# cannot create native image because sun.java2d is not supported.

native-image \
    -H:+PrintAnalysisCallTree \
    -H:EnableURLProtocols=http \
    -H:NativeLinkerOption=-no-pie \
    -H:+StackTrace \
    -H:+ReportUnsupportedElementsAtRuntime \
    -H:+ReportExceptionStackTraces \
    -H:IncludeResources=.*.conf \
    -H:IncludeResources=.*.properties \
    -H:IncludeResources=.*.xml \
    -H:IncludeResourceBundles=oracle.net.mesg.Message \
    -H:ReflectionConfigurationFiles=graal/reflection-xml.json \
    --delay-class-initialization-to-runtime=sun.java2d.opengl.OGLRenderQueue \
    --delay-class-initialization-to-runtime=oracle.sql.LnxLibServer \
    --delay-class-initialization-to-runtime=oracle.sql.LoadCorejava \
    --delay-class-initialization-to-runtime=oracle.jdbc.driver.OracleDriver \
    --delay-class-initialization-to-runtime=oracle.jdbc.driver.OracleTimeoutThreadPerVM \
    --allow-incomplete-classpath \
    -jar target/dbcn-example-1.0.0.jar 

