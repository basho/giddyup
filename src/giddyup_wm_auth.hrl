-define(AUTH_HEADER, "Basic realm=\"GiddyUp\"").

-export([is_authorized/2]).

-include_lib("webmachine/include/webmachine.hrl").

is_authorized(RD, Context) ->
    IsAuth = case wrq:method(RD) of
                 'GET' -> true;
                 'HEAD' -> true;
                 _ ->
                     basic_auth(wrq:get_req_header("authorization",RD))
             end,
    {IsAuth, RD, Context}.

basic_auth("Basic "++Auth) ->
    {User, Password} = giddyup_config:auth(),
    [User, Password] == string:tokens(base64:decode_to_string(Auth), ":");
basic_auth(_) ->
    ?AUTH_HEADER.
