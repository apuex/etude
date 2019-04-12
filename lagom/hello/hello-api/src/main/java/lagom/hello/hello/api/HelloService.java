package lagom.hello.hello.api;

import akka.Done;
import akka.NotUsed;
import com.github.apuex.springbootsolution.runtime.Messages;
import com.github.apuex.springbootsolution.runtime.QueryCommand;
import com.google.protobuf.util.JsonFormat;
import com.lightbend.lagom.javadsl.api.Descriptor;
import com.lightbend.lagom.javadsl.api.Service;
import com.lightbend.lagom.javadsl.api.ServiceCall;
import com.lightbend.lagom.javadsl.api.broker.Topic;
import com.lightbend.lagom.javadsl.api.broker.kafka.KafkaProperties;
import com.lightbend.lagom.javadsl.api.transport.Method;

import static com.lightbend.lagom.javadsl.api.Service.*;

/**
 * The Hello service interface.
 * <p>
 * This describes everything that Lagom needs to know about how to serve and
 * consume the Hello.
 */
public interface HelloService extends Service {

  /**
   * Example: curl http://localhost:9000/api/hello/Alice
   */
  ServiceCall<NotUsed, String> hello(String id);


  /**
   * Example: curl -H "Content-Type: application/json" -X POST -d '{"message":"Hi"}' http://localhost:9000/api/hello/Alice
   */
  ServiceCall<GreetingMessage, Done> useGreeting(String id);

  ServiceCall<QueryCommand, Done> query();


  /**
   * This gets published to Kafka.
   */
  Topic<HelloEvent> helloEvents();

  @Override
  default Descriptor descriptor() {
    JsonFormat.TypeRegistry registry = JsonFormat.TypeRegistry.newBuilder()
        .add(Messages.getDescriptor().getMessageTypes())
        .build();
    // @formatter:off
    return named("hello").withCalls(
        pathCall("/api/hello/:id", this::hello),
        pathCall("/api/hello/:id", this::useGreeting),
        pathCall("/api/query", this::query).withRequestSerializer(new GsonMessageSerializer(QueryCommand.class, registry))
    ).withTopics(
        topic("hello-events", this::helloEvents)
            // Kafka partitions messages, messages within the same partition will
            // be delivered in order, to ensure that all messages for the same user
            // go to the same partition (and hence are delivered in order with respect
            // to that user), we configure a partition key strategy that extracts the
            // name as the partition key.
            .withProperty(KafkaProperties.partitionKeyStrategy(), HelloEvent::getName)
    )
        .withAutoAcl(true);
    // @formatter:on
  }
}
