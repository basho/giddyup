%% @doc After coverage report generated, this resource shoves it out.
-module(giddyup_wm_coverage).

-record(context, {mode, s3_key, stream_key}).

-export([
    init/1,
    routes/0,
    resource_exists/2,
    to_html/2
]).

-include("giddyup_wm_auth.hrl").

routes() ->
    [{["test_results", id, "coverage", '*'], ?MODULE, test_results},
     {["scorecards", id, "coverage", '*'], ?MODULE, scorecards},
     {["scorecards", id, platform, "coverage", '*'], ?MODULE, platforms}].

init(Mode) ->
    {ok, #context{mode = Mode}}.

resource_exists(RD, Context) ->
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
    {Found, RD, Context#context{s3_key = S3Key, stream_key = ReqId}}.

to_html(RD, Context) ->
    {ok, Binary} = read_ibrowse_stream(Context#context.stream_key, <<>>),
    {Binary, RD, Context}.

get_s3_key(RD, test_results) ->
    File = filename:join(["coverage", "test_results", wrq:path_info(id, RD), wrq:disp_path(RD)]),
    maybe_append_index_html(File);

get_s3_key(RD, scorecards) ->
    File = filename:join(["coverage", "scorecards", wrq:path_info(id, RD), wrq:disp_path(RD)]),
    maybe_append_index_html(File);

get_s3_key(RD, platforms) ->
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

