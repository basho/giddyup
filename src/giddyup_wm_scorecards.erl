%% @doc Constructs a test-suite for a given platform and version
-module(giddyup_wm_scorecards).
-compile({inline, [encode_scorecard/1]}).

-export([init/1,
         routes/0,
         resource_exists/2,
         content_types_provided/2,
         to_json/2,
         encodings_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(context, {project, scorecards}).

routes() ->
    [{["projects", project, "scorecards"], ?MODULE, []}].

init([]) ->
    {ok, #context{}}.

encodings_provided(RD, Context) ->
    {[{"identity", fun(X) -> X end},
      {"gzip", fun zlib:gzip/1},
      {"deflate", fun zlib:zip/1}], RD, Context}.

content_types_provided(RD, Context) ->
    {[{"application/json", to_json}], RD, Context}.

resource_exists(RD, Context) ->
    Project = wrq:path_info(project, RD),
    case giddyup_sql:scorecards(Project) of
        {ok, _SCols, Scorecards} ->
            {true, RD, Context#context{project=Project,
                                       scorecards=Scorecards}};
        _ ->
            {false, RD, Context}
    end.

to_json(RD, #context{scorecards=S}=Context) ->
    JSON = {struct,[{scorecards, [ encode_scorecard(Card) || Card <- S]}]},
    {mochijson2:encode(JSON), RD, Context}.
    
encode_scorecard({ID, Name}) ->
    {struct, [{id, ID}, {name, Name}]}.
