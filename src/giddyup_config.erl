%% @doc Helpers for extracting app configuration.
-module(giddyup_config).
-define(SCHEME_DEFAULTS, [{scheme_defaults, [{postgres, 5432},
                                             {postgresql, 5432}]}]).

-export([db_params/0,
         extract_env/0,
         pool_args/0,
         web_config/0,
         s3_config/0,
         auth/0,
         riak_ebins/0]).

db_params() ->
    {ok, {postgres, UserPass, Host, Port, Path, _}} = application:get_env(giddyup, db_url),
    Opts = [{database, filename:basename(Path)} || Path /= "/" ] ++
           [{port, Port} || Port /= 5432 ],
    case string:tokens(UserPass, ":") of
        [] -> [Host, Opts];
        [User] -> [Host, User, Opts];
        [User, Pass] -> [Host, User, Pass, Opts]
    end.

extract_env() ->
    Port = env_or_default("PORT", "5000"),
    IP = env_or_default("IP", "0.0.0.0"),
    DB = env_or_default("DATABASE_URL", "postgres://localhost/giddyup_dev"),
    AuthUser = env_or_default("AUTH_USER", "user"),
    AuthPass = env_or_default("AUTH_PASSWORD", "pass"),
    S3_AKID = os:getenv("S3_AKID"),
    S3_BUCKET = env_or_default("S3_BUCKET", "basho-giddyup-dev"),
    S3_SECRET = os:getenv("S3_SECRET"),
    S3_HOST = env_or_default("S3_HOST", "s3.amazonaws.com"),
    Riak_ebins = generate_ebin_paths(env_or_default("RIAK_LIB_PATH", "")),
    _ = [ application:set_env(giddyup, Key, Value) ||
            {Key, Value} <- [{http_ip, IP},
                             {http_port, list_to_integer(Port)},
                             {db_url, element(2, http_uri:parse(DB, ?SCHEME_DEFAULTS))},
                             {user, AuthUser},
                             {password, AuthPass},
                             {s3, {erlcloud_s3:new(S3_AKID, S3_SECRET, S3_HOST), S3_BUCKET}},
                             {riak_ebins, Riak_ebins}]],
    ok.

s3_config() ->
    {ok, Val} = application:get_env(giddyup, s3),
    Val.

auth() ->
    {ok, User} = application:get_env(giddyup, user),
    {ok, Pass} = application:get_env(giddyup, password),
    {User, Pass}.

pool_args() ->
    [{name, {local, giddyup_sql}},
     {worker_module, giddyup_sql},
     {size, 10},
     {max_overflow, 0}].

riak_ebins() ->
    {ok, Ebins} = application:get_env(giddyup, riak_ebins),
    Ebins.

env_or_default(Key, Default) ->
    case os:getenv(Key) of
        false -> Default;
        Val -> Val
    end.

web_config() ->
    {ok, IP} = application:get_env(giddyup, http_ip),
    {ok, Port} = application:get_env(giddyup, http_port),
    Name = spec_name(http, IP, Port),
    [{name, Name},
     {ip, IP},
     {port, Port},
     {nodelay, true},
     {backlog, 128},
     {dispatch, dispatch()}].

spec_name(Scheme, Ip, Port) ->
    FormattedIP = if is_tuple(Ip); tuple_size(Ip) == 4 ->
                          inet_parse:ntoa(Ip);
                     is_tuple(Ip); tuple_size(Ip) == 8 ->
                          [$[, inet_parse:ntoa(Ip), $]];
                     true -> Ip
                  end,
    lists:flatten(io_lib:format("~s://~s:~p", [Scheme, FormattedIP, Port])).

dispatch() ->
    lists:flatten([
                   giddyup_wm_test_result:routes(),
                   giddyup_wm_artifact:routes(),
                   giddyup_wm_artifacts:routes(),
                   giddyup_wm_matrix:routes(),
                   giddyup_wm_scorecards:routes(),
                   giddyup_wm_suite:routes(),
                   giddyup_wm_projects:routes(),
                   giddyup_wm_coverage:routes(),
                   giddyup_wm_asset:routes()
                  ]).

generate_ebin_paths(UnsplitPath) ->
    Paths = string:tokens(UnsplitPath, ":"),
    lists:foldl(fun(Path, Acc) ->
        Files = filename:join([Path, "*", "ebin"]),
        Acc ++ filelib:wildcard(Files)
    end, [], Paths).

