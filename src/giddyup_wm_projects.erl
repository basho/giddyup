%% @doc Lists the available projects as JSON
-module(giddyup_wm_projects).

-record(context, {projects}).

-export([init/1,
         routes/0,
         service_available/2,
         to_json/2]).

-include_lib("giddyup_wm.hrl").

routes() ->
    [{["projects"], ?MODULE, []}].

init([]) ->
    {ok, #context{}}.

service_available(RD, Context) ->
    case giddyup_sql:projects() of
        {ok, _Columns, Projects} ->
            {true, RD, Context#context{projects=Projects}};
        Error ->
            Body = io_lib:format("Error: ~p~n", [Error]),
            RD1 = wrq:set_resp_header("Content-Type", "text/plain",
                                      wrq:set_resp_body(Body, RD)),
            {false, RD1, Context}
    end.

to_json(RD, #context{projects=Projects}=Context) ->
    JSON = mochijson2:encode(
             {struct,
              [{projects,
                [ {struct, [{name, Name}]} || {_Id, Name} <- Projects]
               }]
             }),
    {JSON, RD, Context}.
