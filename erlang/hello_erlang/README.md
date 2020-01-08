# hello erlang

## Prerequisites

- The minimium OTP version is 19 to support cowboy 2.7.0.
- GNU make.

## Steps to create this project

### Bootstrap

```
$ mkdir hello_erlang
$ cd hello_erlang
$ wget https://erlang.mk/erlang.mk
$ make -f erlang.mk bootstrap bootstrap-rel
```
### Add cowboy dependency

```
PROJECT = hello_erlang

DEPS = cowboy
dep_cowboy_commit = 2.7.0

DEP_PLUGINS = cowboy

include erlang.mk
```

### Listening for connections

```
start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", hello_handler, []}]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    hello_erlang_sup:start_link().
```

### Handling requests

```
$ make new t=cowboy.http n=hello_handler
```

```
init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        <<"Hello Erlang!">>,
        Req0),
    {ok, Req, State}.
```


## References

- [Erlang.mk User Guide](https://erlang.mk/guide/)
- [Getting started - Cowboy 2.7 User Guide](https://ninenines.eu/docs/en/cowboy/2.7/guide/getting_started/)

