%% @doc This is the CLI interface to generate coverage reports for giddyup.
%% It wraps up the logic needed to query, update, and generate coverage
%% reports for giddyup in a stand-alone script so that the reports can be
%% generated using the same resources as what generated the orignal 
%% coverage data.
%%
%% To clarify, when using {@link giddyup_cover/generate_test_result_html/1}
%% directly, it is required that whatever riak is in given libs directory
%% is the same as what was used to generate the inital coverage data. This
%% means to generate coverage reports, riak would need to be installed on
%% whatever machine is running giddyup, and it would need to be the exactly
%% correct versions with the correct directories. This is, frankly, silly.
%%
%% This script is intened to be run on the machine that generated the
%% coverage data. This means the riak version should already be correct,
%% already has a reliable disk (since giddyup is meant to not depend on
%% that).

-module('giddyup-cover').
-export([main/1]).

-define(cli_options, [
    {help, $h, "help", undefined, "Display usage information"},
    {test_result, $t, "test-result", integer, "Generate html for a test result"},
    {scorecard, $s, "scorecard", integer, "Generate html for a scorecard"},
    {platform, $p, "platform", string, "Limit scorecard results to the given platform"},
    {dry_run, $d, "dry-run", {boolean, false}, "Do not upload results to S3"}
]).

main(Args) ->
    {ok, {Options, _Rest}} = getopt:parse(?cli_options, Args),
    case proplists:get_value(help, Options) of
        true ->
            display_help(),
            halt();
        _ ->
            ok
    end,
    check_tmp_dir(),
    lager:start(),
    ok = verify_env_vars_exist(),
    ok = giddyup_config:extract_env(),
    %{ok, _Poolboy} = start_sql_pool(),
    _ = ssl:start(),
    _ = application:start(ibrowse),
    TestIds = proplists:get_all_values(test_result, Options),
    Scorecards = proplists:get_all_values(scorecard, Options),
    PlatformLimits = case proplists:get_all_values(platform, Options) of
        [] -> none;
        Plats -> Plats
    end,
    TestResGen = lists:map(fun generate_test_result_html/1, TestIds),
    ScoreCardGen = case PlatformLimits of
        none ->
            lists:map(fun generate_scorecard_html/1, Scorecards);
        _ ->
            ScorecardPlatPairs = [{ScorecardId, Platform} || ScorecardId <- Scorecards, Platform <- PlatformLimits],
            lists:map(fun({ScorecardId, Platform}) ->
                generate_scorecard_platform_html(ScorecardId, Platform)
            end, ScorecardPlatPairs)
    end,
    ok = wait_for_exits([TestResGen, ScoreCardGen]),
    case proplists:get_value(dry_run, Options) of
        true ->
            ok;
        false ->
            upload_test_result_files(TestIds),
            upload_scorecard_files(Scorecards, PlatformLimits)
    end.

generate_test_result_html(TestResultId) ->
    {ok, "200", _Heads, Binary} = giddyup_fetch(["test_results", TestResultId, "coverdata"]),
    [{struct,Props}] = mochijson2:decode(Binary),
    CoverUrl = proplists:get_value(<<"s3_url">>, Props),
    giddyup_coverage:generate_test_result_html(TestResultId, CoverUrl).

generate_scorecard_html(ScorecardId) ->
    {ok, "200", _Heads, Binary} = giddyup_fetch(["scorecards", ScorecardId, "coverdata"]),
    Json = mochijson2:decode(Binary),
    UrlTestIdPairs = lists:map(fun({struct, Props}) ->
        Id = proplists:get_value(<<"test_result_id">>, Props),
        Url = proplists:get_value(<<"s3_url">>, Props),
        {Url, Id}
    end, Json),
    giddyup_coverage:generate_scorecard_html(ScorecardId, UrlTestIdPairs).

generate_scorecard_platform_html(ScorecardId, Platform) ->
    {ok, "200", _Heads, Binary} = giddyup_fetch(["scorecards", ScorecardId, Platform, "coverdata"]),
    Json = mochijson2:decode(Binary),
    UrlTestIdPairs = lists:map(fun({struct, Props}) ->
        Id = proplists:get_value(<<"test_result_id">>, Props),
        Url = proplists:get_value(<<"s3_url">>, Props),
        {Url, Id}
    end, Json),
    giddyup_coverage:generate_scorecard_platform_html(ScorecardId, Platform, UrlTestIdPairs).

giddyup_fetch(PathParts) ->
    Path = lists:map(fun
        (Str) when is_list(Str) ->
            Str;
        (Bin) when is_binary(Bin) ->
            binary_to_list(Bin);
        (Int) when is_integer(Int) ->
            integer_to_list(Int)
    end, PathParts),
    Host = giddyup_config:giddyup_url(),
    Url = Host ++ "/" ++ filename:join(Path),
    ibrowse:send_req(Url, [{"accept", "application/json; text/html"}], get).

upload_test_result_files(TestIds) when is_list(TestIds) ->
    lists:foreach(fun upload_test_result_files/1, TestIds);

upload_test_result_files(TestResultId) ->
    IdStr = integer_to_list(TestResultId),
    WildcardStr = filename:join(["tmp", "coverage", "test_results", IdStr, "*.html"]),
    Files = filelib:wildcard(WildcardStr),
    lists:map(fun(PrefixedFile) ->
        "tmp/" ++ File = PrefixedFile,
        {ok, Bin} = file:read_file(PrefixedFile),
        io:format("upload ~s to ~s~n", [PrefixedFile, File]),
        giddyup_artifact:upload(File, "text/html", Bin)
    end, Files).

upload_scorecard_files(ScorecardIds, PlatformLimits) when is_list(ScorecardIds) ->
    lists:foreach(fun(ScorecardId) ->
        upload_scorecard_files(ScorecardId, PlatformLimits)
    end, ScorecardIds);

upload_scorecard_files(ScorecardId, none) ->
    WildcardStr = filename:join(["tmp", "coverage", "scorecards", integer_to_list(ScorecardId), "all", "*.html"]),
    LocalFiles = filelib:wildcard(WildcardStr),
    KeyFilePairs = lists:map(fun(LocalFile) ->
        ["tmp", "coverage", "scorecards", IdStr, "all", ActualFile] = filename:split(LocalFile),
        Key = filename:join(["coverage", "scorecards", IdStr, ActualFile]),
        {Key, LocalFile}
    end, LocalFiles),
    lists:foreach(fun({Key, File}) ->
        {ok, Bin} = file:read_file(File),
        io:format("upload ~s to ~s~n", [File, Key]),
        giddyup_artifact:upload(Key, "text/html", Bin)
    end, KeyFilePairs);

upload_scorecard_files(ScorecardId, [Platform | _Tail] = Platforms) when is_list(Platform) ->
    lists:foreach(fun(PlatformName) ->
        upload_scorecard_files(ScorecardId, PlatformName)
    end, Platforms);

upload_scorecard_files(ScorecardId, PlatformName) ->
    WildcardStr = filename:join(["tmp", "coverage", "scorecards", integer_to_list(ScorecardId), PlatformName, "*.html"]),
    LocalFiles = filelib:wildcard(WildcardStr),
    lists:foreach(fun(LocalFile) ->
        "tmp/" ++ Key = LocalFile,
        {ok, Bin} = file:read_file(LocalFile),
        io:format("upload ~s to ~s~n", [LocalFile, Key]),
        giddyup_artifact:upload(Key, "text/html", Bin)
    end, LocalFiles).

check_tmp_dir() ->
    Dir = filename:join(["tmp", "coverage", "plunk"]),
    case filelib:ensure_dir(Dir) of
        ok ->
            ok;
        Else ->
            io:format("Could not create tmp directory ~s: ~p", [Dir, Else]),
            halt(1)
    end.

%start_sql_pool() ->
%    Spec = poolboy:child_spec(giddyup_sql, giddyup_config:pool_args(), giddyup_config:db_params()),
%    {_SpecId, {Module, Function, PoolboyArgs}, _Durability, _KillTime, _Role, _Modules} = Spec,
%    erlang:apply(Module, Function, PoolboyArgs).

wait_for_exits([]) ->
    ok;

wait_for_exits([Head | Tail]) when is_list(Head) ->
    wait_for_exits(Head),
    wait_for_exits(Tail);

wait_for_exits([Pid | Tail]) when is_pid(Pid) ->
    Mon = erlang:monitor(process, Pid),
    receive
        {'DOWN', Mon, process, Pid, _Why} ->
            wait_for_exits(Tail)
    end;

wait_for_exits([NotPid | Tail]) ->
    io:format("Error: ~p~n", [NotPid]),
    wait_for_exits(Tail).

verify_env_vars_exist() ->
    EnvNames = ["GIDDYUP_URL", "S3_AKID", "S3_BUCKET", "S3_SECRET", "RIAK_LIB_PATH"],
    AllSet = lists:all(fun(Name) ->
        case os:getenv(Name) of
            false -> false;
            _ -> true
        end
    end, EnvNames),
    if
        AllSet ->
            ok;
        true ->
            display_help(),
            io:format("\nOne or more env variables was not set!\n"),
            halt(1)
    end.

display_help() ->
    HelpText =
"Generates coverage report html based on the coverage data uploaded to "
"giddyup for the given test results. The source code and compiled modules "
"need to be available to this script in order to work properly. Also, the "
"versions on the local machine should match those used to generate the "
"coverage data.\n"
"\n"
"Much of the configuration needed to make this work is taken from the "
"OS environment. Specifically the S3 access, where giddyup is hosted, "
"and where the riak lib directory is.\n"
"\n"
"OS enviroment variables are:\n"
"    GIDDYUP_URL\n"
"    S3_AKID\n"
"    S3_BUCKET\n"
"    S3_SECRET\n"
"    RIAK_LIB_PATH\n"
"\n"
"Note that when doing a scorecard, all test restult coverage reports are "
"generated as well.\n",
    ok = getopt:usage(?cli_options, "giddyup-cover"),
    io:format("~s", [HelpText]).
