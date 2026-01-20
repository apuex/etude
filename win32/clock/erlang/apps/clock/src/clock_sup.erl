-module(clock_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  spawn_link(fun() -> supervisor:start_child(?MODULE, []) end),

  RestartStrategy = simple_one_for_one,
  MaxR = 10000,
  MaxT = 1,
  SupFlags = {RestartStrategy, MaxR, MaxT},
  StartFunc = {clock, start_link, []},
  Restart = permanent,
  Shutdown = infinity,
  Modules = [clock],
  Type = worker,
  ChildSpec = { clock
              , StartFunc
              , Restart
              , Shutdown
              , Type
              , Modules
              },
  {ok, {SupFlags, [ChildSpec]}}.

