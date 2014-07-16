%% @doc Helpers for interacting with S3 for artifacts
-module(giddyup_artifact).
-include_lib("erlcloud/include/erlcloud_aws.hrl").

-export([url_for/2,
         key_for/2,
         upload/3,
         stream_download/1]).

url_for(ResultID, Segments) ->
    {#aws_config{s3_host=Host,
                 s3_port=Port}, Bucket} = giddyup_config:s3_config(),
    Key = key_for(ResultID, Segments),
    Scheme = case Port of
                 443 -> "https";
                 _ -> "http"
             end,
    lists:flatten(io_lib:format("~s://~s.~s:~p/~s", [Scheme, Bucket, Host, Port, Key])).

key_for(ResultID, Segments) ->
    filename:join([integer_to_list(ResultID)|Segments]).

upload(Key, CType, Content) ->
    {Config, Bucket} = giddyup_config:s3_config(),
    erlcloud_s3:put_object(Bucket, Key, Content,
                        [{return_response, true}, {acl, public_read}],
                        [{"Content-Type", CType}], Config).

stream_download(URL) ->
    IBOpts = [{response_format, binary},
              {stream_to, self()}],
    ibrowse:send_req(URL, [], get, [], IBOpts, infinity).
