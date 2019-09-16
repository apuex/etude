# transposed

performance test for transposed data(rows to columns).

## Build

### Generate Model

```
cd transposed-model
sbt assembly
java -jar target/scala-2.12/transposed-model-0.1.0.jar > ../insert-transposed/insert-transposed-model/src/main/resources/insert-transposed-model.xml
```

### Generate Code from Model

```
java -Doutput.dir=$(pwd) -Dsymbol.naming=unix_c -jar ~/github/apuex/spring-boot-solution/codegen/target/scala-2.12/codegen.jar generate-all insert-transposed/insert-transposed-model/src/main/resources/insert-transposed-model.xml
```

### Build and Run

```
cd insert-transposed
mvn package
java -jar insert-transposed-app/target/insert-transposed-app-1.0-SNAPSHOT.war
```



