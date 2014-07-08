-module(giddyup_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    WebConfig = giddyup_config:web_config(),
    {ok, {
       {one_for_one, 5, 10}, 
       [
        %% Pool over pgsql
        poolboy:child_spec(giddyup_sql, giddyup_config:pool_args(), giddyup_config:db_params()),
        %% Webmachine listener
        {proplists:get_value(name, WebConfig), {webmachine_mochiweb, start, WebConfig},
         permanent, 5000, worker, [webmachine_mochiweb, mochiweb_socket_server]}
       ]} }.
