-module(hello).

-export([start/0, send/2, call/2, loop/1]).

start() ->
  process_flag(trap_exit, true),
  Port = open_port({spawn, "C:\\usr64\\bin\\hello.exe C:\\usr64\\bin\\hello.txt"}, [{packet, 2}, binary]),
  loop(Port).

send(Port, Msg) ->
  Port ! {self(), {command, term_to_binary(Msg)}}.

call(Port, Req) ->
  Port ! {self(), {command, term_to_binary(Req)}},
  receive
    {Port, {data, Rsp}} -> binary_to_term(Rsp)
  end.

loop(Port) ->
  %io:fwrite("loop(~p)~n", [Port]),
  receive
    {Port, {data, Rsp}} ->
      io:fwrite("Message: ~p~n", [Rsp]);

    {Pid, {command, Req}} ->
      %io:fwrite("receive from Pid: ~p, Req: ~p~n", [Pid, Req]),
      %io:fwrite("send to Port: ~p, Req: ~p~n", [Port, Req]),
      Port ! {self(), {command, Req}},
      receive
        {Port, {command, Rsp}} -> io:fwrite("command: ~p~n", [Rsp]);
        {Port, {data, Rsp}} ->
          %io:fwrite("data: ~p~n", [Rsp]),
          Pid ! {self(), {data, Rsp}};
        _Else -> io:fwrite("_Else2: ~p, ~p~n", [Port, _Else])
      end;

    {'EXIT', Port, _Status} -> io:fwrite("Exit: ~p~n", [_Status]);

    _Else -> io:fwrite("_Else1: ~p, ~p~n", [Port, _Else])

  end,
  loop(Port).

