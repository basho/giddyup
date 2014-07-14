%% @doc Lists scorecards for the selected project
-module(giddyup_wm_scorecards).
-compile({inline, [encode_scorecard/2]}).

-export([init/1,
         routes/0,
         resource_exists/2,
         to_json/2]).

-include_lib("giddyup_wm.hrl").

-record(context, {project, scorecards}).

routes() ->
    [{["projects", project, "scorecards"], ?MODULE, []}].

init([]) ->
    {ok, #context{}}.

resource_exists(RD, Context) ->
    Project = wrq:path_info(project, RD),
    case giddyup_sql:scorecards(Project) of
        {ok, _SCols, Scorecards} ->
            {true, RD, Context#context{project=Project,
                                       scorecards=Scorecards}};
        _ ->
            {false, RD, Context}
    end.

to_json(RD, #context{scorecards=S, project=Project}=Context) ->
    JSON = {struct,[{scorecards, [ encode_scorecard(Card, Project) || Card <- S]}]},
    {mochijson2:encode(JSON), RD, Context}.
    
encode_scorecard({ID, Name}, Project) ->
    {struct, [{id, ID}, {name, Name}, {project, list_to_binary(Project)}]}.
