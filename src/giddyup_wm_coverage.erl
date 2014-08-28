%% @doc After coverage report generated, this resource shoves it out.
-module(giddyup_wm_coverage).

-record(context, {mode, s3_key, stream_key, sql_res}).

-export([
    init/1,
    routes/0,
    resource_exists/2,
    content_types_provided/2,
    to_html/2,
    to_json/2
]).

-include("giddyup_wm_auth.hrl").

routes() ->
    [{["test_results", id, "coverdata"], ?MODULE, {test_results, coverdata}},
     {["test_results", id, "coverage", '*'], ?MODULE, {test_results, report}},
     {["scorecards", id, "coverdata"], ?MODULE, {scorecards, coverdata}},
     {["scorecards", id, "coverage", '*'], ?MODULE, {scorecards, report}},
     {["scorecards", id, platform, "coverdata"], ?MODULE, {platforms, coverdata}},
     {["scorecards", id, platform, "coverage", '*'], ?MODULE, {platforms, report}}].

init(Mode) ->
    {ok, #context{mode = Mode}}.

resource_exists(RD, Context = #context{mode = {_, report}}) ->
    S3Key = get_s3_key(RD, Context#context.mode),
    Url = giddyup_artifact:url_for(S3Key),
    {ibrowse_req_id, ReqId} = giddyup_artifact:stream_download(Url),
    Status = receive
        {ibrowse_async_headers, ReqId, StatusStr, _Headers} ->
            StatusStr
    after
        60000 ->
            lager:debug("404 for ~s due to timeout", [S3Key]),
            "404"
    end,
    Found = case Status of
        "20" ++ _ ->
            true;
        _ ->
            lager:debug("~s for ~s", [Status, S3Key]),
            false
    end,
    {Found, RD, Context#context{s3_key = S3Key, stream_key = ReqId}};

resource_exists(RD, Context) ->
    Id = list_to_integer(wrq:path_info(id, RD)),
    SQLRes = case Context#context.mode of
        {test_results, _} ->
            giddyup_sql:test_result_coverage(Id);
        {scorecards, _} ->
            giddyup_sql:scorecard_coverage(Id);
        {platforms, _} ->
            Platform = wrq:path_info(platform, RD),
            giddyup_sql:scorecard_coverage(Id, Platform)
    end,
    Exists = case SQLRes of
        {ok, _ColumnInfo, Rows} when length(Rows) > 0 ->
            true;
        _ ->
            false
    end,
    {Exists, RD, Context#context{sql_res = SQLRes}}.

content_types_provided(RD, Context = #context{mode = {_, report}}) ->
    {[{"text/html", to_html}], RD, Context};
content_types_provided(RD, Context = #context{mode = {_, coverdata}}) ->
    {[{"application/json", to_json}], RD, Context}.

to_html(RD, Context) ->
    {ok, Binary} = read_ibrowse_stream(Context#context.stream_key, <<>>),
    {Binary, RD, Context}.

to_json(RD, Context = #context{mode = {test_results, _}}) ->
    {ok, _ColumnInfo, [{URL}]} = Context#context.sql_res,
    Json = [
        {struct, [
            {<<"test_result_id">>, wrq:path_info(id, RD)},
            {<<"s3_url">>, URL}
        ]}
    ],
    Binary = mochijson2:encode(Json),
    {Binary, RD, Context};

to_json(RD, Context) ->
    {ok, _ColumnInfo, UrlTestIdPairs} = Context#context.sql_res,
    Json = lists:map(fun({Url, TestId}) ->
        {struct, [
            {<<"test_result_id">>, TestId},
            {<<"s3_url">>, Url}
        ]}
    end, UrlTestIdPairs),
    Binary = mochijson2:encode(Json),
    {Binary, RD, Context}.

get_s3_key(RD, {test_results, _}) ->
    File = filename:join(["coverage", "test_results", wrq:path_info(id, RD), wrq:disp_path(RD)]),
    maybe_append_index_html(File);

get_s3_key(RD, {scorecards, _}) ->
    File = filename:join(["coverage", "scorecards", wrq:path_info(id, RD), wrq:disp_path(RD)]),
    maybe_append_index_html(File);

get_s3_key(RD, {platforms, _}) ->
    File = filename:join(["coverage", "scorecards", wrq:path_info(id, RD), wrq:path_info(platform, RD), wrq:disp_path(RD)]),
    maybe_append_index_html(File).

maybe_append_index_html(File) ->
    case filename:extension(File) of
        ".html" ->
            File;
        _ ->
            filename:join(File, "index.html")
    end.

read_ibrowse_stream(ReqID, AccBin) ->
    receive
        {ibrowse_async_headers, ReqID, _StatusStr, _Headers} ->
            read_ibrowse_stream(ReqID, AccBin);
        {ibrowse_async_response, ReqID, BodyChunk} ->
            NewAcc = <<AccBin/binary, BodyChunk/binary>>,
            read_ibrowse_stream(ReqID, NewAcc);
        {ibrowse_async_response_end, ReqID} ->
            {ok, AccBin}
    after
        60000 ->
            {error, timeout}
    end.

