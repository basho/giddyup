%% @doc Generate coverage reports from riak_test cover data. Riak_test can
%% run tests with cover compiled modules and upload the results as an
%% artifact to giddyup. This module generates static html for coverage for
%% a single test result, all test results for a scorecard, and all test
%% results for a single platform on a scorecard. This is achieved by
%% downloading the cover data and using the erlang cover application to
%% combine them.
%%
%% This means that this module needs access not only to the riak source,
%% but also the compiled modules. It will dynamically add the modules as
%% needed, but it does need to know where riak is. The os environment
%% varialbe RIAK_LIB_PATH should point to the lib dir in a riak release.
%%
%% All coverage data and generate html scripts are stored in the
%% 'tmp/coverage' directory.

-module(giddyup_coverage).

-export([
    generate_test_result_html/1,
    generate_scorecard_html/2,
    generate_scorecard_html/1
]).

-define(test_result_www_dir(TestResId), filename:join(["tmp", "coverage", "test_results", integer_to_list(TestResId)])).
-define(scorecard_www_dir(ScorecardId, Platform), filename:join(["tmp", "coverage", "scorecards", maybe_to_list(ScorecardId), maybe_to_list(Platform)])).

%% @doc Generate (or re-generate) the static html coverage report for a
%% single test result.
generate_test_result_html(TestResultId) ->
    {ok, _, [{URL}]} = giddyup_sql:test_result_coverage(TestResultId),
    generate_test_result_html(TestResultId, URL).

generate_test_result_html(TestResultId, URL) ->
    {ok, {{200, _}, _Headers, GzBody}} = sync_stream_artifact(URL),
    ok = prepare_dirs(TestResultId),
    {ok, _CoverPid} = prepare_cover(),
    cover_analysis(GzBody, TestResultId, URL),
    cover:stop(),
    analyze(?test_result_www_dir(TestResultId)).

maybe_generate_test_result_html(TestResultId, URL) ->
    IndexFile = filename:join([?test_result_www_dir(TestResultId), "index.html"]),
    case filelib:is_file(IndexFile) of
        true ->
            ok;
        false ->
            generate_test_result_html(TestResultId, URL)
    end.

generate_test_results_html(UrlTestIdList) ->
    lists:foreach(fun({Url, TestResultId}) ->
        maybe_generate_test_result_html(TestResultId, Url)
    end, UrlTestIdList).

%% @doc Generate (or re-generate) the static html coverage report for a
%% scorecard, but only for the given platform. This will generate the
%% static html for any test results needed, but will not re-generate them.
generate_scorecard_html(ScorecardId, PlatformStr) ->
    {ok, _ColumnInfo, Rows} = giddyup_sql:scorecard_coverage(ScorecardId, PlatformStr),
    generate_test_results_html(Rows),
    CoverFiles = lists:foldl(fun({_Url, TestResId}, Acc) ->
        Wildcard = filename:join([?test_result_www_dir(TestResId), "*.cover.txt"]),
        Files = filelib:wildcard(Wildcard),
        Files ++ Acc
    end, [], Rows),
    analyze(CoverFiles, ?scorecard_www_dir(ScorecardId, PlatformStr)).

%% @doc Generate (or re-generate) the static html coverage report for
%% all tests on all platforms for the given scorecard. This will generate
%% the static html for any test results that do not exist.
generate_scorecard_html(ScorecardId) ->
    {ok, _ColumnInfo, Rows} = giddyup_sql:scorecard_coverage(ScorecardId),
    generate_test_results_html(Rows),
    CoverFiles = lists:foldl(fun({_Url, TestResId}, Acc) ->
        Wildcard = filename:join([?test_result_www_dir(TestResId), "*.cover.txt"]),
        Files = filelib:wildcard(Wildcard),
        Files ++ Acc
    end, [], Rows),
    analyze(CoverFiles, ?scorecard_www_dir(ScorecardId, "all")).

prepare_dirs(TestResultId) ->
    ok = filelib:ensure_dir(?test_result_www_dir(TestResultId)).

prepare_cover() ->
    PathsToAdd = giddyup_config:riak_ebins(),
    code:add_pathsz(PathsToAdd),
    cover:stop(),
    cover:start().

cover_analysis(GzBody, TestResId, URL) ->
    Body = zlib:gunzip(GzBody),
    [Name] = binary:split(lists:last(binary:split(URL, <<"/">>, [global])), <<".gz">>, [trim]),
    CoverFileName = filename:join([?test_result_www_dir(TestResId), Name]),
    filelib:ensure_dir(CoverFileName),
    file:write_file(CoverFileName, Body),
    cover:import(CoverFileName),
    W = lists:map(fun(M) ->
        case is_good(M) of
            true ->
                WriteToFile = filename:join([?test_result_www_dir(TestResId), atom_to_list(M) ++ ".cover.txt"]),
                cover:async_analyse_to_file(M, WriteToFile);
            false ->
                lager:debug("module ~s was not good for cover analysis", [M]),
                []
        end
    end, cover:imported_modules()),
    ok = wait_for_workers(lists:flatten(W)).

sync_stream_artifact(Url) when is_binary(Url) ->
    sync_stream_artifact(binary_to_list(Url));

sync_stream_artifact(Url) ->
    {ibrowse_req_id, ReqId} = giddyup_artifact:stream_download(Url),
    sync_stream_artifacts_wait(ReqId, undefined, undefined, <<>>).

sync_stream_artifacts_wait(ReqId, OldStatus, OldHeaders, OldBody) ->
    receive
        {ibrowse_async_headers, ReqId, StatusStr, Headers} ->
            StatusInt = list_to_integer(StatusStr),
            sync_stream_artifacts_wait(ReqId, StatusInt, Headers, OldBody);
        {ibrowse_async_response, ReqId, BodyChunk} ->
            NewBody= <<OldBody/binary, BodyChunk/binary>>,
            sync_stream_artifacts_wait(ReqId, OldStatus, OldHeaders, NewBody);
        {ibrowse_async_response_end, ReqId} ->
            {ok, {{OldStatus, undefined}, OldHeaders, OldBody}}
    after
        60000 ->
            {error, timeout}
    end.

mod_src(M) ->
    try M:module_info(compile) of
        Props ->
            case filelib:is_regular(proplists:get_value(source, Props)) of
                true ->
                    proplists:get_value(source, Props);
                false ->
                    lager:debug("could not find source for ~s", [M]),
                    undefined
            end
    catch _:_ ->
        lager:debug("Could not load module ~s", [M]),
        undefined
    end.

is_good(M) ->
    case mod_src(M) of
        undefined ->
            false;
        _ ->
            true
    end.

wait_for_workers([]) ->
    ok;

wait_for_workers(Workers) when is_list(Workers) ->
    MonPids = lists:map(fun(Pid) ->
        MonRef = erlang:monitor(process, Pid),
        {MonRef, Pid}
    end, Workers),
    Set = sets:from_list(MonPids),
    wait_for_workers(Set);

wait_for_workers(Set) ->
    Element = receive
        {'DOWN', Mon, process, Pid, Normal} when Normal == normal; Normal == noproc ->
            {Mon, Pid};
        {'DOWN', Mon, process, Pid, Why} ->
            lager:info("~p exited due to ~p", [Pid, Why]),
            {Mon, Pid}
    end,
    Set2 = sets:del_element(Element, Set),
    case sets:size(Set2) of
        0 ->
            ok;
        _ ->
            wait_for_workers(Set2)
    end.

analyze(Dir) ->
    lager:debug("running analysis on ~s", [Dir]),
    CoverFiles = filelib:fold_files(Dir, ".*.cover.txt", true, fun(Fname, Acc) -> [Fname | Acc] end, []),
    analyze(CoverFiles, Dir).

analyze(CoverFiles, OutputDir) ->
    lager:debug("output directory: ~s", [OutputDir]),
    OutputIndex = filename:join(OutputDir, "index.html"),
    ok = filelib:ensure_dir(OutputIndex),
    {ok, F} = file:open(OutputIndex, [write]),
    Sub = spawn(fun() ->
                %lager:info("subdirs for ~p are ~p", [Dir, SubDirs]),
                lager:debug("coverfiles given: ~p", [CoverFiles]),
                CD = calculate_coverage(CoverFiles),

                Workers = [spawn(fun() -> write_cover_file(OutputDir, M, lists:flatten(D)) end) || {M, D} <- CD],

                Modules = group_by_app(coverage_modules(CD)),

                CData = lists:map(fun({App, Mods}) ->
                            {App, [begin
                                            Coalesced = coalesce(lists:flatten(proplists:get_value(atom_to_list(M), CD))),

                                            {Run, NotRun} = lists:partition(fun({_, {_, Calls}}) -> Calls > 0 end, Coalesced),
                                            {M, percent(length(Run), length(Run)+length(NotRun)), {length(Run), length(NotRun)}}
                                    end || M <- Mods]}
                    end, Modules),

                receive
                    lieutenant_green ->
                        %% ok safe to write to the HTML file now
                        lists:foreach(fun({App, Mods}) when Mods /= [] ->
                                    file:write(F, ["<h2>", App,"/<h2><table>"]),
                                    [file:write(F, "<tr><td><a href=\"coverage/"++atom_to_list(M) ++ ".html\">" ++atom_to_list(M) ++ "</a></td><td>" ++ integer_to_list(Percent) ++ "%</td></tr>") || {M, Percent, _} <- lists:keysort(2, Mods)],
                                    {TotalCovered, TotalNotCovered} = lists:foldl(fun({_, _, {Cov, NotCov}}, {T1, T2}) ->
                                                {T1+Cov, T2+NotCov}
                                        end, {0, 0}, Mods),
                                    Total = percent(TotalCovered, TotalCovered + TotalNotCovered),
                                    file:write(F, ["<tr><td></td><td></td></tr><tr><td>Total</td><td>", integer_to_list(Total), "%</td></tr>"]),
                                    file:write(F, "</table>");
                                ({App,_}) ->
                                    lager:debug("Skipping ~p due to no modules", [App]),
                                    ok
                            end, CData),
                        file:write(F, "</table>")
                end,
                wait_for_workers(Workers)
        end),

    {ok, FilesInOutputDir} = file:list_dir(OutputDir),
    SubDirs = [filename:join([OutputDir, D]) || D <- FilesInOutputDir, filelib:is_dir(filename:join(OutputDir, D))],
    file:write(F, "<h1>Individual coverage</h1><table>"),
    case SubDirs of
        [] -> ok;
        _ ->
            [summarize(SubDir, F) || SubDir <- lists:sort(SubDirs)],
            file:write(F, "</table>"),
            file:write(F, "<h1>Aggregate coverage</h1><table>")
    end,
    Sub ! lieutenant_green,
    Sub.

coalesce([]) -> [];
coalesce(CD0) ->
    CD = lists:keysort(1, CD0),
    {LastCoveredLine, _} = lists:last(CD),
    lists:foldl(fun(Line, Acc) ->
                case proplists:get_all_values(Line, CD) of
                    [] ->
                        Acc;
                    Cov ->
                        Calls = [{Module, Calls} || {Module, Calls} <- Cov, Calls > 0],
                        case Calls of
                            [] ->
                                [{Line, hd(Cov)}|Acc];
                            _ ->
                                [{Line, hd(Calls)}|Acc]
                        end
                end
        end, [], lists:seq(1, LastCoveredLine)).

summarize(Dir, F) ->
    CoverFiles = filelib:fold_files(Dir, ".*.cover.txt", true, fun(E, A) -> [E|A] end, []),
    case CoverFiles of
        [] ->
            case {filelib:is_regular(filename:join(Dir, "failed")), filelib:is_regular(filename:join(Dir, "no_cover"))} of
                {true, _} ->
                    file:write(F, ["<tr><td>",filename:basename(Dir), "</td><td>test failed</td></tr>"]);
                {_, true} ->
                    file:write(F, ["<tr><td>",filename:basename(Dir), "</td><td>no coverage</td></tr>"]);
                IsRegulars ->
                    lager:warning("Coverfiles ~p not valid in ~s: ~p", [CoverFiles, Dir, IsRegulars]),
                    file:write(F, ["<tr><td>",filename:basename(Dir), "</td><td>unknown</td></tr>"])
            end;
        _ ->
            file:write(F, ["<tr><td><a href=\"./coverage/", filename:basename(Dir), "\">", filename:basename(Dir), "</a></td><td>"]),
            file:write(F, [total_coverage(calculate_coverage(CoverFiles)), "</td></tr>"])
    end.

read_cover_data(File) ->
    Mod = filename:basename(File, ".cover.txt"),
    TestMod = filename:basename(filename:dirname(File)),
    {ok, Bin} = file:read_file(File),
    RawLines = binary:split(Bin, <<"\n">>, [global]),
    Lines = lists:sublist(RawLines, 5, length(RawLines)),
    {_, Res} = lists:foldl(fun(Line, {LineNo, Dict}) ->
                case re:run(Line, <<"^ +([0-9]+)\.*|">>, [{capture, all_but_first, list}]) of
                    {match, []} ->
                        {LineNo+1, Dict};
                    {match, [NumStr]} ->
                        Num = list_to_integer(NumStr),
                        {LineNo+1, dict:store(LineNo, {TestMod, Num}, Dict)}
                end
        end, {1, dict:new()}, Lines),
    {Mod, dict:to_list(Res)}.

write_cover_file(Dir, Mod, CD) when is_binary(Mod) ->
    write_cover_file(Dir, binary_to_list(Mod), CD);

write_cover_file(Dir, Mod, CD) ->
    {ok, F} = file:open(filename:join([Dir, Mod++".html"]), [write]),
    file:write(F, "<html><head>
        <link rel='stylesheet' type='text/css' href='/hint.min.css'>
        <style>
            p {
                margin: 0em;
            }
            p:nth-child(odd)
            {
                background:Gainsboro;
            }
            p:nth-child(even)
            {
                background:LightGray;
            }
            p.run:nth-child(even) {
                background: PaleGreen;
            }
            p.run:nth-child(odd) {
                background: LightGreen;
            }
            p.notrun:nth-child(even) {
                background: LightSalmon;
            }
            p.notrun:nth-child(odd) {
                background: DarkSalmon;
            }
        </style></head><body>"),
    {ok, Bin} = file:read_file(mod_src(list_to_atom(Mod))),
    Lines = binary:split(Bin, <<"\n">>, [global]),
    lists:foldl(fun(Line0, Number) ->
                Line = binary:replace(binary:replace(binary:replace(binary:replace(Line0, <<" ">>, <<"&nbsp;">>, [global]), <<"	">>, <<"&nbsp;&nbsp;">>, [global]), <<"<">>, <<"&lt;">>, [global]), <<">">>, <<"&gt;">>, [global]),
                case proplists:get_all_values(Number, CD) of
                    [] ->
                        file:write(F, ["<p>", Line, "</p>"]);
                    Cov ->
                        Calls = [{Module, Calls} || {Module, Calls} <- Cov, Calls > 0],
                        case Calls of
                            [] ->
                                file:write(F, ["<p class='notrun'>", Line, "</p>"]);
                            _ ->
                                file:write(F, ["<p class='run'><span class='hint  hint--top' data-hint='Covered by: ", string:join([M++"&nbsp;("++integer_to_list(CC)++"&nbsp;calls)" || {M, CC} <- Calls], ", "), "'>", Line, "</span></p>"])
                        end
                end,
                Number + 1
        end, 1, Lines),
    file:write(F, "</body></html>"),
    file:close(F).

calculate_coverage(CoverFiles) ->
    Res = lists:foldl(fun(File, Dict) ->
                {Mod, CD} = read_cover_data(File),
                dict:append(Mod, CD, Dict)
        end, dict:new(), CoverFiles),
    lists:keysort(1, dict:to_list(Res)).

coverage_modules(CD) ->
    lists:sort([list_to_atom(M) || {M, _} <- CD]).

total_coverage(CD) ->
    {A, B} = lists:foldl(fun({_Module, CD2}, {Covered, NotCovered}) ->
                {Run, NotRun} = lists:partition(fun({_, {_, Calls}}) -> Calls > 0 end, coalesce(lists:flatten(CD2))),
                {Covered + length(Run), NotCovered + length(NotRun)}
        end, {0, 0}, CD),
    integer_to_list(percent(A, A+B)) ++ "%".

percent(0, 0) -> 0;
percent(Part, All) ->
    trunc((Part / All) * 100).

group_by_app(Modules) ->
    lists:sort(dict:to_list(lists:foldl(fun(M, Dict) ->
                App = filename:basename(filename:dirname(filename:dirname(code:which(M)))),
                dict:append(App, M, Dict)
        end, dict:new(), Modules))).

maybe_to_list(Bin) when is_binary(Bin) ->
    binary_to_list(Bin);

maybe_to_list(Int) when is_integer(Int) ->
    integer_to_list(Int);

maybe_to_list(List) when is_list(List) ->
    List.

