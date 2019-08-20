# Problems

Timeout & bind error while startup:

```
*******************************
starting bin/startup.sh on 2019-08-19 13:01:53
*******************************
[info] p.a.d.DefaultDBApi - Database [tree_system] initialized at jdbc:mysql://mysql:3306/tree_system?characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&useSSL=false&verifyServerCertificate=false
[info] application - Creating Pool for datasource 'tree_system'
[error] a.r.Remoting - Remoting system has been terminated abrubtly. Attempting to shut down transports
[error] a.r.t.n.NettyTransport - failed to bind to tree-system/172.18.0.6:2553, shutting down Netty transport
[error] a.r.Remoting - Remoting system has been terminated abrubtly. Attempting to shut down transports
[error] a.r.t.n.NettyTransport - failed to bind to tree-system/172.18.0.6:2553, shutting down Netty transport
[error] a.r.Remoting - Remoting system has been terminated abrubtly. Attempting to shut down transports
Oops, cannot start the server.
com.google.inject.CreationException: Unable to create injector, see the following errors:
1) Error injecting method, java.util.concurrent.TimeoutException: Futures timed out after [10000 milliseconds]
  at com.google.inject.util.Providers$GuicifiedProviderWithDependencies.initialize(Providers.java:154)
  at play.api.libs.concurrent.AkkaGuiceSupport.bindActor(AkkaGuiceSupport.scala:64) (via modules: com.google.inject.util.Modules$OverrideModule -> com.wincom.tree.service.Module)
Caused by: java.util.concurrent.TimeoutException: Futures timed out after [10000 milliseconds]
    at scala.concurrent.impl.Promise$DefaultPromise.ready(Promise.scala:259)
    at scala.concurrent.impl.Promise$DefaultPromise.result(Promise.scala:263)
    at scala.concurrent.Await$.$anonfun$result$1(package.scala:219)
    at scala.concurrent.BlockContext$DefaultBlockContext$.blockOn(BlockContext.scala:57)
    at scala.concurrent.Await$.result(package.scala:146)
    at akka.remote.Remoting.start(Remoting.scala:205)
    at akka.remote.RemoteActorRefProvider.init(RemoteActorRefProvider.scala:233)
    at akka.cluster.ClusterActorRefProvider.init(ClusterActorRefProvider.scala:37)
    at akka.actor.ActorSystemImpl.liftedTree2$1(ActorSystem.scala:913)
    at akka.actor.ActorSystemImpl._start$lzycompute(ActorSystem.scala:909)
    at akka.actor.ActorSystemImpl._start(ActorSystem.scala:909)
    at akka.actor.ActorSystemImpl.start(ActorSystem.scala:931)
    at akka.actor.ActorSystem$.apply(ActorSystem.scala:258)
    at play.api.libs.concurrent.ActorSystemProvider$.start(Akka.scala:204)
    at play.api.libs.concurrent.ActorSystemProvider$.start(Akka.scala:143)
    at play.api.libs.concurrent.ActorSystemProvider.get$lzycompute(Akka.scala:109)
    at play.api.libs.concurrent.ActorSystemProvider.get(Akka.scala:109)
    at play.api.libs.concurrent.ActorSystemProvider.get(Akka.scala:106)
    at com.google.inject.internal.ProviderInternalFactory.provision(ProviderInternalFactory.java:85)
    at com.google.inject.internal.BoundProviderFactory.provision(BoundProviderFactory.java:77)
    at com.google.inject.internal.ProviderInternalFactory.circularGet(ProviderInternalFactory.java:59)
    at com.google.inject.internal.BoundProviderFactory.get(BoundProviderFactory.java:61)
    at com.google.inject.internal.SingleFieldInjector.inject(SingleFieldInjector.java:52)
    at com.google.inject.internal.MembersInjectorImpl.injectMembers(MembersInjectorImpl.java:147)
    at com.google.inject.internal.MembersInjectorImpl.injectAndNotify(MembersInjectorImpl.java:101)
    at com.google.inject.internal.MembersInjectorImpl.injectMembers(MembersInjectorImpl.java:71)
    at com.google.inject.internal.InjectorImpl.injectMembers(InjectorImpl.java:1014)
    at com.google.inject.util.Providers$GuicifiedProviderWithDependencies.initialize(Providers.java:154)
    at com.google.inject.util.Providers$GuicifiedProviderWithDependencies$$FastClassByGuice$$2a7177aa.invoke(<generated>)
    at com.google.inject.internal.SingleMethodInjector$1.invoke(SingleMethodInjector.java:51)
    at com.google.inject.internal.SingleMethodInjector.inject(SingleMethodInjector.java:85)
    at com.google.inject.internal.MembersInjectorImpl.injectMembers(MembersInjectorImpl.java:147)
    at com.google.inject.internal.MembersInjectorImpl.injectAndNotify(MembersInjectorImpl.java:101)
    at com.google.inject.internal.Initializer$InjectableReference.get(Initializer.java:245)
    at com.google.inject.internal.Initializer.injectAll(Initializer.java:140)
    at com.google.inject.internal.InternalInjectorCreator.injectDynamically(InternalInjectorCreator.java:176)
    at com.google.inject.internal.InternalInjectorCreator.build(InternalInjectorCreator.java:109)
    at com.google.inject.Guice.createInjector(Guice.java:87)
    at com.google.inject.Guice.createInjector(Guice.java:78)
    at play.api.inject.guice.GuiceBuilder.injector(GuiceInjectorBuilder.scala:201)
    at play.api.inject.guice.GuiceApplicationBuilder.build(GuiceApplicationBuilder.scala:156)
    at play.api.inject.guice.GuiceApplicationLoader.load(GuiceApplicationLoader.scala:22)
    at play.core.server.ProdServerStart$.start(ProdServerStart.scala:59)
    at play.core.server.ProdServerStart$.main(ProdServerStart.scala:31)
    at play.core.server.ProdServerStart.main(ProdServerStart.scala)
2) Error in custom provider, org.jboss.netty.channel.ChannelException: Failed to bind to: tree-system/172.18.0.6:2553
  while locating play.api.libs.concurrent.ActorSystemProvider
  while locating akka.actor.ActorSystem
    for field at play.api.cache.ehcache.NamedAsyncCacheApiProvider.actorSystem(EhCacheApi.scala:147)
  while locating play.api.cache.ehcache.NamedAsyncCacheApiProvider
  at com.google.inject.util.Providers$GuicifiedProviderWithDependencies.initialize(Providers.java:154)
  at play.api.cache.ehcache.EhCacheModule$$anonfun$$lessinit$greater$1.bindCache$1(EhCacheApi.scala:93):
Binding(interface play.api.cache.AsyncCacheApi qualified with QualifierInstance(@play.cache.NamedCache(value=play)) to ProviderTarget(play.api.cache.ehcache.NamedAsyncCacheApiProvider@7f8633ae)) (via modules: com.google.inject.util.Modules$OverrideModule -> play.api.inject.guice.GuiceableModuleConversions$$anon$4)
Caused by: org.jboss.netty.channel.ChannelException: Failed to bind to: tree-system/172.18.0.6:2553
    at org.jboss.netty.bootstrap.ServerBootstrap.bind(ServerBootstrap.java:272)
    at akka.remote.transport.netty.NettyTransport.$anonfun$listen$1(NettyTransport.scala:538)
    at scala.util.Success.$anonfun$map$1(Try.scala:255)
    at scala.util.Success.map(Try.scala:213)
    at scala.concurrent.Future.$anonfun$map$1(Future.scala:292)
    at scala.concurrent.impl.Promise.liftedTree1$1(Promise.scala:33)
    at scala.concurrent.impl.Promise.$anonfun$transform$1(Promise.scala:33)
    at scala.concurrent.impl.CallbackRunnable.run(Promise.scala:64)
    at akka.dispatch.BatchingExecutor$AbstractBatch.processBatch(BatchingExecutor.scala:55)
    at akka.dispatch.BatchingExecutor$BlockableBatch.$anonfun$run$1(BatchingExecutor.scala:92)
    at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
    at scala.concurrent.BlockContext$.withBlockContext(BlockContext.scala:85)
    at akka.dispatch.BatchingExecutor$BlockableBatch.run(BatchingExecutor.scala:92)
    at akka.dispatch.TaskInvocation.run(AbstractDispatcher.scala:40)
    at akka.dispatch.ForkJoinExecutorConfigurator$AkkaForkJoinTask.exec(ForkJoinExecutorConfigurator.scala:49)
    at akka.dispatch.forkjoin.ForkJoinTask.doExec(ForkJoinTask.java:260)
    at akka.dispatch.forkjoin.ForkJoinPool$WorkQueue.runTask(ForkJoinPool.java:1339)
    at akka.dispatch.forkjoin.ForkJoinPool.runWorker(ForkJoinPool.java:1979)
    at akka.dispatch.forkjoin.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:107)
Caused by: java.net.BindException: Address already in use
    at sun.nio.ch.Net.listen(Native Method)
    at sun.nio.ch.ServerSocketChannelImpl.bind(ServerSocketChannelImpl.java:224)
    at sun.nio.ch.ServerSocketAdaptor.bind(ServerSocketAdaptor.java:74)
    at org.jboss.netty.channel.socket.nio.NioServerBoss$RegisterTask.run(NioServerBoss.java:193)
    at org.jboss.netty.channel.socket.nio.AbstractNioSelector.processTaskQueue(AbstractNioSelector.java:391)
    at org.jboss.netty.channel.socket.nio.AbstractNioSelector.run(AbstractNioSelector.java:315)
    at org.jboss.netty.channel.socket.nio.NioServerBoss.run(NioServerBoss.java:42)
    at org.jboss.netty.util.ThreadRenamingRunnable.run(ThreadRenamingRunnable.java:108)
    at org.jboss.netty.util.internal.DeadLockProofWorker$1.run(DeadLockProofWorker.java:42)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
    at java.lang.Thread.run(Thread.java:748)
3) Error in custom provider, org.jboss.netty.channel.ChannelException: Failed to bind to: tree-system/172.18.0.6:2553
  while locating play.api.libs.concurrent.ActorSystemProvider
  while locating akka.actor.ActorSystem
    for field at play.api.libs.concurrent.ActorRefProvider.actorSystem(Akka.scala:238)
  while locating play.api.libs.concurrent.ActorRefProvider
  at com.google.inject.util.Providers$GuicifiedProviderWithDependencies.initialize(Providers.java:154)
  at play.api.libs.concurrent.AkkaGuiceSupport.bindActor(AkkaGuiceSupport.scala:64) (via modules: com.google.inject.util.Modules$OverrideModule -> com.wincom.tree.shard.Module)
Caused by: org.jboss.netty.channel.ChannelException: Failed to bind to: tree-system/172.18.0.6:2553
    at org.jboss.netty.bootstrap.ServerBootstrap.bind(ServerBootstrap.java:272)
    at akka.remote.transport.netty.NettyTransport.$anonfun$listen$1(NettyTransport.scala:538)
    at scala.util.Success.$anonfun$map$1(Try.scala:255)
    at scala.util.Success.map(Try.scala:213)
    at scala.concurrent.Future.$anonfun$map$1(Future.scala:292)
    at scala.concurrent.impl.Promise.liftedTree1$1(Promise.scala:33)
    at scala.concurrent.impl.Promise.$anonfun$transform$1(Promise.scala:33)
    at scala.concurrent.impl.CallbackRunnable.run(Promise.scala:64)
    at akka.dispatch.BatchingExecutor$AbstractBatch.processBatch(BatchingExecutor.scala:55)
    at akka.dispatch.BatchingExecutor$BlockableBatch.$anonfun$run$1(BatchingExecutor.scala:92)
    at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
    at scala.concurrent.BlockContext$.withBlockContext(BlockContext.scala:85)
    at akka.dispatch.BatchingExecutor$BlockableBatch.run(BatchingExecutor.scala:92)
    at akka.dispatch.TaskInvocation.run(AbstractDispatcher.scala:40)
    at akka.dispatch.ForkJoinExecutorConfigurator$AkkaForkJoinTask.exec(ForkJoinExecutorConfigurator.scala:49)
    at akka.dispatch.forkjoin.ForkJoinTask.doExec(ForkJoinTask.java:260)
    at akka.dispatch.forkjoin.ForkJoinPool$WorkQueue.runTask(ForkJoinPool.java:1339)
    at akka.dispatch.forkjoin.ForkJoinPool.runWorker(ForkJoinPool.java:1979)
    at akka.dispatch.forkjoin.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:107)
Caused by: java.net.BindException: Address already in use
    at sun.nio.ch.Net.bind0(Native Method)
    at sun.nio.ch.Net.bind(Net.java:433)
    at sun.nio.ch.Net.bind(Net.java:425)
    at sun.nio.ch.ServerSocketChannelImpl.bind(ServerSocketChannelImpl.java:223)
    at sun.nio.ch.ServerSocketAdaptor.bind(ServerSocketAdaptor.java:74)
    at org.jboss.netty.channel.socket.nio.NioServerBoss$RegisterTask.run(NioServerBoss.java:193)
    at org.jboss.netty.channel.socket.nio.AbstractNioSelector.processTaskQueue(AbstractNioSelector.java:391)
    at org.jboss.netty.channel.socket.nio.AbstractNioSelector.run(AbstractNioSelector.java:315)
    at org.jboss.netty.channel.socket.nio.NioServerBoss.run(NioServerBoss.java:42)
    at org.jboss.netty.util.ThreadRenamingRunnable.run(ThreadRenamingRunnable.java:108)
    at org.jboss.netty.util.internal.DeadLockProofWorker$1.run(DeadLockProofWorker.java:42)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
    at java.lang.Thread.run(Thread.java:748)
3 errors
    at com.google.inject.internal.Errors.throwCreationExceptionIfErrorsExist(Errors.java:543)
    at com.google.inject.internal.InternalInjectorCreator.injectDynamically(InternalInjectorCreator.java:178)
    at com.google.inject.internal.InternalInjectorCreator.build(InternalInjectorCreator.java:109)
    at com.google.inject.Guice.createInjector(Guice.java:87)
    at com.google.inject.Guice.createInjector(Guice.java:78)
    at play.api.inject.guice.GuiceBuilder.injector(GuiceInjectorBuilder.scala:201)
    at play.api.inject.guice.GuiceApplicationBuilder.build(GuiceApplicationBuilder.scala:156)
    at play.api.inject.guice.GuiceApplicationLoader.load(GuiceApplicationLoader.scala:22)
    at play.core.server.ProdServerStart$.start(ProdServerStart.scala:59)
    at play.core.server.ProdServerStart$.main(ProdServerStart.scala:31)
    at play.core.server.ProdServerStart.main(ProdServerStart.scala)
```

actually no duplicate port error in configuration file, 
the problem is caused by name resolution of docker containers takes too long, which causes timeout in start of cluster shard, which causes play guice DI error.

solution:

1. change to newer version of docker.
2. change start up timeout value to a larger value.

```
akka {
  remote {
    startup-timeout = 60 s  // default is 10 s
  }
}
```


