# hello-impl

## how to run

1. get dependencies.

```
mvn dependency:copy-dependencies
mv target/dependencies/ lib/
```

2. remove kafka if not needed.

```
find lib -name "*kafka*.jar" -exec rm -f {} \;
```

3. package jar

```
ant package -Dproject.name=hello-impl -Dproject.version=1.0.0 -Dmain.class=play.core.server.ProdServerStart
```

4. run jar

```
java -jar target/hello-impl.jar
```

## kafka

kafka can be disabled by removing `*kafka*.jar` dependencies.
