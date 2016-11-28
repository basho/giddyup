%% 2. Accept an artifact from a test run
%% 3. Slurp through an artifact from S3 on behalf of the app
-module(giddyup_wm_artifact).

-record(context, {method,
                  id,
                  ctype,
                  key,
                  artifact}).

-export([init/1,
         routes/0,
         malformed_request/2,
         allowed_methods/2,
         content_types_accepted/2,
         content_types_provided/2,
         resource_exists/2,
         allow_missing_post/2,
         post_is_create/2,
         create_path/2,
         accept_file/2,
         to_file/2,
         to_json/2]).

%% Can't use encoders when streaming, but needs to authenticate POST.
-include("giddyup_wm_auth.hrl").

routes() ->
    [{["test_results", id, "artifacts", '*'], fun is_post/1, ?MODULE, [create]},
     {["artifacts", id], ?MODULE, [fetch]}].

init([Method]) ->
    {ok, #context{method=Method}}.

malformed_request(RD, Context) ->
    IDStr = wrq:path_info(id, RD),
    try
        ID = list_to_integer(IDStr),
        {false, RD, Context#context{id=ID}}
    catch
        _:_ ->
            {true, RD, Context}
    end.

content_types_provided(RD, #context{method=create}=Context) ->
    {[{"application/octet-stream", to_file}], RD, Context};
content_types_provided(RD, #context{method=fetch}=Context) ->
    {CType, NewContext} = get_artifact_ctype(Context),
    {[{"application/json", to_json},
      {binary_to_list(CType), to_file}], RD, NewContext}.


content_types_accepted(RD, Context) ->
    CType = wrq:get_req_header("content-type", RD),
    {[{CType, accept_file}], RD, Context#context{ctype=CType}}.

allowed_methods(RD, #context{method=create}=Context) ->
    {['POST'], RD, Context};
allowed_methods(RD, #context{method=fetch}=Context) ->
    {['GET'], RD, Context}.

allow_missing_post(RD, Context) ->
    {true, RD, Context}.

post_is_create(RD, Context) ->
    {true, RD, Context}.

resource_exists(RD, #context{method=create}=Context) ->
    {false, RD, Context};
resource_exists(RD, #context{artifact=undefined}=Context) ->
    {false, RD, Context};
resource_exists(RD, #context{artifact={_,_,_}}=Context) ->
    {true, RD, Context}.

create_path(RD, Context) ->
    case giddyup_sql:next_id("artifacts") of
        {ok, _, [{ID}]} ->
            {"/artifacts/" ++ integer_to_list(ID), RD, Context#context{artifact=ID}};
        Err ->
            {{error, Err}, RD, Context}
    end.

accept_file(RD, #context{id=TestResultID, ctype=CType, artifact=ID}=Context) ->
    try
        case CType of
            %% Special handling of compressed websites
            "binary/tgz-website" ->
                giddyup_wm_site:accept_site(RD, TestResultID, ID);
            _ ->
                upload_artifact(RD, CType, TestResultID, ID)
        end,
        {true, RD, Context}
    catch
        error:{aws_error,Err} ->
            lager:debug("AWS upload failed: ~p", [Err]),
            {{halt, 502},
             wrq:set_resp_header("content-type", "text/plain",
                                 wrq:set_resp_body(io_lib:format("AWS upload failed:~n~p", [Err]), RD)),
             Context};
        Class:Why ->
            {{error, {Class,Why}}, RD, Context}
    end.

upload_artifact(RD, CType, TestResultID, ID) ->
    Segments = wrq:path_tokens(RD),
    URL = giddyup_artifact:url_for(TestResultID, Segments),
    Key = giddyup_artifact:key_for(TestResultID, Segments),
    {_H, _B} = giddyup_artifact:upload(Key, CType, wrq:req_body(RD)),
    {ok, _} = giddyup_sql:create_artifact(ID, TestResultID, URL, CType).

to_file(RD, #context{artifact={_ID, URL, _CType}}=Context) ->
    {ibrowse_req_id, ReqID} = giddyup_artifact:stream_download(binary_to_list(URL)),
    {{stream, stream_s3_body(ReqID)}, RD, Context}.

to_json(RD, #context{artifact={ID, URL, CType}}=Context) ->
    {mochijson2:encode({struct, [
                                 {artifact,
                                  {struct, [{id, ID},
                                            {url, URL},
                                            {content_type, CType}]}
                                 }
                                ]}), RD, Context}.

%%------------------------
%% Private functions
%%------------------------
is_post(RD) ->
    wrq:method(RD) == 'POST'.

get_artifact_ctype(#context{id=ID}=Context) ->
    case giddyup_sql:q("SELECT id, url, content_type FROM artifacts WHERE id = $1", [ID]) of
        {ok, _, [Artifact={ID, _URL, CType}]} ->
            {CType, Context#context{artifact=Artifact}};
        _ ->
            {"application/octet-stream", Context}
    end.

stream_s3_body(ReqId) ->
    receive
        {ibrowse_async_headers, ReqId, _, _} ->
            stream_s3_body(ReqId);
        {ibrowse_async_response, ReqId, Chunk} ->
            {Chunk, fun() -> stream_s3_body(ReqId) end};
        {ibrowse_async_response_end, ReqId} ->
            {<<>>, done}
    end.
