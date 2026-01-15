-module(clock).

-export([start/1, stop/0, init/1]).

-export([call_port/1, cast_port/1]).

-export([currentmillis/0]).

-export([convert_to_os_encoding/1]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

currentmillis() ->
  <<CurrentMillis:64/big-unsigned-integer>> = call_port(<<0:16, 0:16>>),
  CurrentMillis.
    

%% ------------------------------------------------------------------
%% Erlang Port Function Definitions
%% ------------------------------------------------------------------

start(ExtPrg) ->
  spawn(?MODULE, init, [ExtPrg]).

stop() ->
  clock_port ! stop.

call_port(Msg) ->
  clock_port ! {call, self(), Msg},
  receive
    {clock_port, Result} ->
      Result
  end.

cast_port(Msg) ->
  clock_port ! {cast, self(), Msg}.

init(ExtPrg) ->
  register(clock_port, self()),
  process_flag(trap_exit, true),
  Port = open_port( { spawn, ExtPrg }
                  , [ binary
                    , {packet, 2} % {packet, N :: 1 | 2 | 4} | stream
                    , use_stdio
                    , exit_status
                    , stderr_to_stdout
                    ]
                  ),
  loop(Port).

receive_response(Port, Caller, _Req) ->
  receive
    {Port, {data, Data}} ->
      console_log("Reply Data = <<~ts>>.", [format_byte_list(Data)]),
      Caller ! {clock_port, Data};
    M ->
      console_log("Unhandled Message=~p", [M])
  end.

loop(Port) ->
  receive
    {call, Caller, Msg} ->
      Port ! {self(), {command, Msg}},
      receive_response(Port, Caller, Msg),
      loop(Port);
    {cast, _Caller, Msg} ->
      Port ! {self(), {command, Msg}},
      loop(Port);
    {Port, {data, Data}} ->
      console_log("Push Data = <<~ts>>.", [format_byte_list(Data)]),
      loop(Port);
    stop ->
      Port ! {self(), close},
      receive
        {Port, closed} ->
          port_close(Port),
          exit(normal)
      end;
    {'EXIT', Port, _Reason} ->
      exit(port_terminated);
    _X ->
      io:format("Unhandled message ~p~n", [_X]),
      loop(Port)
  end.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

convert_to_os_encoding(Unicode) ->
  StringBin = unicode:characters_to_binary(Unicode),
  case os:type() of
    { win32, nt } ->
      iconv:convert( <<"UTF-8">>
                   , <<"GB18030">>
                   , StringBin
                   );
    _ -> Unicode
  end.

format_byte(Byte) ->
  BL = integer_to_list(Byte, 16),
  if length(BL) < 2 -> "0" ++ BL;
     true -> BL
  end.

join(D, L) ->
  case L of
    [] -> [];
    [H] -> H;
    [H|T] ->
      H ++ D ++ join(D, T)
  end.

format_byte_list(Bin) ->
  LS = lists:map(fun(X) -> "16#" ++ format_byte(X) end, binary_to_list(Bin)),
  join(", ", LS).

console_log(Msg, Param) ->
  {{Y,Mon,D}, {H,Min,S}} = calendar:local_time(),
  TS = io_lib:format("~4.10.0B-~2.10.0B-~2.10.0B ~2.10.0B:~2.10.0B:~2.10.0B", [Y,Mon,D, H,Min,S]),
  io:format(lists:concat(["[~ts] ", Msg, "~n"]), lists:concat([[TS], Param])).

