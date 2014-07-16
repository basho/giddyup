-module(giddyup_wm_test_result).

-record(context, {test_result}).

-export([init/1,
         routes/0,
         allowed_methods/2,
         resource_exists/2,
         post_is_create/2,
         allow_missing_post/2,
         create_path/2,
         content_types_accepted/2,
         accept_json/2]).

-include("giddyup_wm_auth.hrl").

init([]) ->
    {ok, #context{}}.

routes() ->
    [{["test_results"], ?MODULE, []}].

allowed_methods(RD, Context) ->
    {['POST'], RD, Context}.

resource_exists(RD, Context) ->
    {false, RD, Context}.

post_is_create(RD, Context) ->
    {true, RD, Context}.

allow_missing_post(RD, Context) ->
    {true, RD, Context}.

content_types_accepted(RD, Context) ->
    {[{"application/json", accept_json}], RD, Context}.

create_path(RD, Context) ->
    case giddyup_sql:next_id("test_results") of
        {ok, _, [{ID}]} ->
            {"/test_results/" ++ integer_to_list(ID), RD, Context#context{test_result=ID}};
        _ ->
            {false, RD, Context}
    end.

accept_json(RD, #context{test_result=ID}=Context) ->
    try
        JSON = mochijson2:decode(wrq:req_body(RD)),
        TestID = kvc:path(id, JSON),
        Status = coerce_status(kvc:path(status, JSON)),
        Version = kvc:path(version, JSON),
        {ok, _, [{ProjectID, _ProjectName}]} = giddyup_sql:project_exists(kvc:path(project, JSON)),
        ScorecardID = case giddyup_sql:create_scorecard(ProjectID, Version) of
                          {ok, _, _, [{Created}]} -> Created;
                          {ok, _, [{Found}]} -> Found
                      end,          
        {ok, 1} = giddyup_sql:create_test_result(ID, TestID, ScorecardID, Version, Status),
        {true, RD, Context}
    catch
        Class:Why ->
            lager:error("Test result could not be created: ~p:~p~n~p", [Class, Why, erlang:get_stacktrace()]),
            {{error, {Class, Why}}, RD, Context}
    end.

coerce_status(true) -> true;
coerce_status("true") -> true;
coerce_status(<<"true">>) -> true;
coerce_status("pass") -> true;
coerce_status(<<"pass">>) -> true;
coerce_status(_) -> false.
