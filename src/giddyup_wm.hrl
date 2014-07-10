-export([encodings_provided/2,
         content_types_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").

encodings_provided(RD, Context) ->
    {[{"identity", fun(X) -> X end},
      {"gzip", fun zlib:gzip/1},
      {"deflate", fun zlib:zip/1}], RD, Context}.

content_types_provided(RD, Context) ->
    {[{"application/json", to_json}], RD, Context}.
