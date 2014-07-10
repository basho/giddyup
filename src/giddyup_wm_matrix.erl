-module(giddyup_wm_matrix).

-export([init/1,
         routes/0,
         resource_exists/2,
         to_json/2,
         expand_matrix/1]).

-record(context, {scorecard, matrix}).

-include("giddyup_wm.hrl").

routes() ->
    [{["scorecards", id, "matrix"], ?MODULE, []}].

init([]) ->
    {ok, #context{}}.

resource_exists(RD, Context) ->
    ID = list_to_integer(wrq:path_info(id, RD)),
    case giddyup_sql:scorecard_exists(ID) of
        true ->
            case giddyup_sql:full_matrix(ID) of
                {ok, _Cols, Rows} ->
                    {true, RD, Context#context{scorecard=ID,
                                               matrix=Rows}};
                _ ->
                    {false, RD, Context}
            end;
        false ->
            {false, RD, Context}
    end.

to_json(RD, #context{matrix=M}=Context) ->
    JSON = {struct, [{tests, expand_matrix(M)}]},
    {mochijson2:encode(JSON), RD, Context}.

expand_matrix(M) ->
    {_LastID, LastResults, LastEntry, Tree} = lists:foldr(fun fold_matrix/2, {undefined, undefined, undefined, []}, M),
    [complete_entry(LastEntry, LastResults)|Tree].

%% This has several transitions needed to build the tree:
%%
%% 1. Initial condition where there's nothing in the accumulator. In
%%    this case, we make the row's ID the current one and start
%%    accumulating results.
%% 2. When encounter a new test ID, we combine the accumulated results
%%    and the test data into a complete struct and push it onto the tree.
%% 3. When encounter the same test ID, but a new result, we add it to
%%    the accumulated results.
%%
%% These are implemented by the following three clauses, respectively.
fold_matrix({TestID, Name, Platform, Backend, Upgrade, ResultID, Status, LongVersion, CreatedAt},
            {undefined, _, _, Tree}) ->
    {TestID,
     add_result(ResultID, Status, LongVersion, CreatedAt, []),
     create_entry(TestID, Name, Platform, Backend, Upgrade),
     Tree};

fold_matrix({TestID, Name, Platform, Backend, Upgrade, ResultID, Status, LongVersion, CreatedAt},
            {LastID, LastResults, LastEntry, Tree}) when TestID /= LastID ->
    {TestID,
     add_result(ResultID, Status, LongVersion, CreatedAt, []),
     create_entry(TestID, Name, Platform, Backend, Upgrade),
     [complete_entry(LastEntry, LastResults)|Tree]};

fold_matrix({TestID, _Name, _Platform, _Backend, _Upgrade, ResultID, Status, LongVersion, CreatedAt},
            {TestID, LastResults, LastEntry, Tree}) ->
    {TestID,
     add_result(ResultID, Status, LongVersion, CreatedAt, LastResults),
     LastEntry,
     Tree}.


add_result(null, _, _, _, List) -> List;
add_result(ID, Status, Version, Created, List) ->
    [{struct, [{id, ID},
               {status, Status},
               {long_version, Version},
               {created_at, giddyup:isotime(Created)}]}|List].

create_entry(ID, N, P, B, U) ->
    [{id, ID}, {name, N}, {platform, P}] ++
    [ {K, V} || {K, V} <- [{backend, B}, {upgrade_version, U}],
                V /= null ].

complete_entry(Props, Results) ->
    {struct, Props ++ [{test_results, Results}]}.
