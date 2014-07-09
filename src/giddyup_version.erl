-module(giddyup_version).
-export([parse/1, strict_parse/1]).
-define(VERSION_REGEX, "\\d+[.]\\d+[.]\\d+\\w*").
-define(STRICT_REGEX, "\\d+[.]\\d+[.]\\d+").

parse(Vsn) ->
    case re:run(Vsn, ?VERSION_REGEX, [{capture, first, list}]) of
        {match, [NormalVsn]} ->
            NormalVsn;
        nomatch -> Vsn
    end.

strict_parse(Vsn) ->
    {match, [Strict]} = re:run(Vsn, ?STRICT_REGEX, [{capture, first, list}]),
    Strict.
