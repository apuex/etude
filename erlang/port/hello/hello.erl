-module(hello).

-export([start/0, send/2, call/2]).

start() ->
  process_flag(trap_exit, true),
  open_port({spawn, "C:\\usr32\\bin\\hello.exe C:\\usr32\\bin\\hello.txt"}, [{packet, 2}, binary]).

send(Port, Msg) ->
  Port ! {self(), {command, term_to_binary(Msg)}}.

call(Port, Req) ->
  Port ! {self(), {command, term_to_binary(Req)}},
  receive
    {Port, {data, Rsp}} -> binary_to_term(Rsp)
  end.
