%% @doc Constructs a test-suite for a given platform and version
-module(giddyup_wm_suite).

-export([init/1,
         routes/0,
         resource_exists/2,
         to_json/2]).

-include("giddyup_wm.hrl").

-record(context, {project, platform, version, test_cols, tests}).

route_guard(RD) ->
    wrq:get_qs_value("platform", RD) /= undefined andalso
        wrq:get_qs_value("version", RD) /= undefined.

routes() ->
    [{["projects", project], fun route_guard/1, ?MODULE, []}].

init([]) ->
    {ok, #context{}}.

resource_exists(RD, Context) ->
    Project = wrq:path_info(project, RD),
    Platform = wrq:get_qs_value("platform", RD),
    Version = giddyup_version:parse(wrq:get_qs_value("version", RD)),
    case giddyup_sql:project_exists(Project) of
        {ok, _Cols, [{ID, Name}]} ->
            case giddyup_sql:suite(ID, Platform, Version) of
                {ok, TCols, Tests} ->
                    {true, RD, Context#context{project=Name,
                                               platform=Platform,
                                               version=Version,
                                               test_cols=giddyup_sql:extract_column_names(TCols),
                                               tests=Tests
                                               }};
                _ ->
                    {false, RD, Context}
            end;
        _ ->
            {false, RD, Context}
    end.

to_json(RD, #context{project=Project,
                     test_cols=Cols,
                     tests=Tests}=Context) ->
    JSON = {struct,
            [{project, [{name, Project},
                        {tests, encode_tests(Cols, Tests)}]}]},
    {mochijson2:encode(JSON), RD, Context}.


encode_tests(Columns, Tests) ->
    [ encode_test(Columns, Test) || Test <- Tests].

encode_test(Columns, TestT) ->
    Test = tuple_to_list(TestT),
    Props = lists:zip(Columns, Test),
    {value, ID, Props1} = lists:keytake(<<"id">>, 1, Props),
    {value, Name, Props2} = lists:keytake(<<"name">>, 1, Props1),
    %% TODO: don't split into tags, just emit the necessary stuff
    {struct, [ID, Name,
              {tags, {struct, [{K, V} || {K, V} <- Props2, V /= null]}}
             ]}.
