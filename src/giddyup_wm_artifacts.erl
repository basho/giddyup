%% 1. List artifacts for a test result
-module(giddyup_wm_artifacts).

-export([init/1,
         routes/0,
         resource_exists/2,
         to_json/2]).

-record(context, {test_result, artifacts}).

-include("giddyup_wm.hrl").

init([]) ->
    {ok, #context{}}.

routes() ->
    [{["test_results", id, "artifacts"], ?MODULE, []}].

resource_exists(RD, Context) ->
    ID = list_to_integer(wrq:path_info(id, RD)),
    case giddyup_sql:artifacts(ID) of
        {ok, _Cols, Rows} ->
            {true, RD, Context#context{test_result=ID,
                                       artifacts=Rows}};
        _ ->
            {false, RD, Context}
    end.

to_json(RD, #context{artifacts=As}=Context) ->
    JSON = {struct, [{artifacts, [encode_artifact(A) || A <- As]}]},
    {mochijson2:encode(JSON), RD, Context}.

encode_artifact({ID, Url, Ctype, _TS}) ->
    {struct, [{id, ID},
              {url, Url},
              {content_type, Ctype}]}.
