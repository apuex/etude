-module(clock).

-behaviour(gen_server).

-export([ init/1
        , handle_call/3
        , handle_cast/2
        , handle_info/2
        , terminate/2
        , code_change/3
        , start_link/0
        ]).

-export([ currentmillis/0
        , system_time/1
        , steady_time/1
        , system_time_rfc3339/0
        , local_time_rfc3339/0
        , benchmark/2
        ]).

-export([convert_to_os_encoding/1]).

-record(state, { port }).

%% Path to the c-program.
-define(SERVERDIR, filename:nativename(
		     filename:join(code:priv_dir(clock), "bin"))).

%% Name of the C program
-define(SERVERPROG, "clock_port").

start_link() ->
  ServerProg = application:get_env(?MODULE, clock_port, ?SERVERPROG),
  gen_server:start_link({local, ?MODULE}, ?MODULE, [ServerProg], []).

init([ServerProg]) ->
  process_flag(trap_exit, true),
  %% Start the port program (a c program) that utilizes the clock driver
  case os:find_executable(ServerProg, ?SERVERDIR) of
    FileName when is_list(FileName)->
      Port = open_port( {spawn, "\""++FileName++"\""}
                      , [ binary
                        , {packet, 2} % {packet, N :: 1 | 2 | 4} | stream
                        , use_stdio
                        , exit_status
                        , stderr_to_stdout
                        ]
                      ),
      {ok, #state { port = Port } };
    false ->
      io:format("ServerProg=~p Not Found~n", [ServerProg]),
      {stop, port_program_executable_not_found}
  end.

handle_call(Request, _From, State = #state { port = Port }) ->
  Port ! {self(), {command, Request}},
  receive
    {Port, {data, Result}} ->
      {reply, Result, State};
    X ->
      io:format("X=~p~n", [X]),
      {reply, X, State}
  end.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(Info, State = #state { port = Port }) ->
  io:format("Info=~p~n", [Info]),
  case Info of
    {Port, {data, Data}} ->
      console_log("Push Data = <<~ts>>.", [format_byte_list(Data)]);
    {'EXIT', Port, _Reason} ->
      exit(port_terminated);
    _X ->
      console_log("Unhandled message ~p", [_X])
  end,
  {noreply, State}.

terminate(_Reason, _State = #state { port = Port }) ->
  Port ! stop,
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

call_port(Request) ->
  gen_server:call(?MODULE, Request).

currentmillis() ->
  <<CurrentMillis:64/big-unsigned-integer>> = call_port(<<0:16, 1:16>>),
  CurrentMillis.

system_time(Unit) ->
  case Unit of
    second ->
      <<Time:64/big-unsigned-integer>> = call_port(<<0:16, 0:16>>),
      Time;
    millisecond ->
      currentmillis();
    microsecond ->
      <<Time:64/big-unsigned-integer>> = call_port(<<0:16, 2:16>>),
      Time;
    nanosecond ->
      <<Time:64/big-unsigned-integer>> = call_port(<<0:16, 3:16>>),
      Time;
    _ -> error
  end.

steady_time(Unit) ->
  case Unit of
    second ->
      <<Time:64/big-unsigned-integer>> = call_port(<<1:16, 0:16>>),
      Time;
    millisecond ->
      <<Time:64/big-unsigned-integer>> = call_port(<<1:16, 1:16>>),
      Time;
    microsecond ->
      <<Time:64/big-unsigned-integer>> = call_port(<<1:16, 2:16>>),
      Time;
    nanosecond ->
      <<Time:64/big-unsigned-integer>> = call_port(<<1:16, 3:16>>),
      Time;
    _ -> error
  end.

system_time_rfc3339() ->
  binary_to_list(call_port(<<2:16, 0:16>>)).

local_time_rfc3339() ->
  binary_to_list(call_port(<<3:16, 0:16>>)).

benchmark(Fun, Count) ->
  Start = currentmillis(),
  case Fun of
    currentmillis ->
      lists:foreach( fun(_) -> currentmillis() end
                   , lists:duplicate(Count, 0)
                   );
    system_time_rfc3339 ->
      lists:foreach( fun(_) -> system_time_rfc3339() end
                   , lists:duplicate(Count, 0)
                   );
    local_time_rfc3339 ->
      lists:foreach( fun(_) -> local_time_rfc3339() end
                   , lists:duplicate(Count, 0)
                   )
  end,
  Stop = currentmillis(),
  Stop - Start.

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

