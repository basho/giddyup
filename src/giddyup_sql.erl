%% @doc SQL worker process wrapper and queries/updates
-module(giddyup_sql).
-compile({inline, [projects_q/0]}).
-define(QUERY(Q), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q) end)).
-define(QUERY(Q, F), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q, F) end).

-export([
         start_link/1,
         projects/0
        ]).

start_link(Args) ->
    %% TODO: make this a proper wrapper, prepare statements
    erlang:apply(pgsql, connect, Args).

projects() ->
    ?QUERY(projects_q()).

%% test_result_i() ->
%%     "INSERT INTO test_results (test_id, scorecard_id, long_version, status, created_at, updated_at) "
%%     "VALUES ($1, $2, $3, $4, NOW(), NOW()) "
%%     "RETURNING id".

%% artifact_i() ->
%%     "INSERT INTO artifacts (test_result_id, url, content_type, created_at, updated_at) "
%%     "VALUES ($1, $2, $3, NOW(), NOW()) "
%%     "RETURNING id".

projects_q() ->
    "SELECT * FROM projects".

%% scorecards_q() ->
%%     "SELECT * FROM scorecards WHERE project_id = $1 "
%%     "ORDER BY name DESC".

%% suite_q() ->
%%     "SELECT tests.* FROM tests, projects_tests "
%%     "WHERE tests.id = projects_tests.test_id"
%%     "   AND projects_tests.project_id = $1"
%%     "   AND platform = $2"
%%     "   AND (tests.min_version IS NULL OR tests.min_version <= $3)"
%%     "   AND (tests.max_version IS NULL OR tests.max_version >= $3) "
%%     "ORDER BY name, backend, upgrade_version".

%% matrix_q() ->
%%     "SELECT tests.* FROM tests, projects_tests "
%%     "WHERE tests.id = projects_tests.test_id AND projects_tests.project_id = $1 "
%%     "   AND (tests.min_version IS NULL OR tests.min_version <= $2) "
%%     "   AND (tests.max_version IS NULL OR tests.max_version >= $2) "
%%     "ORDER BY name, platform, backend, upgrade_version".

%% all_results_q() ->
%%     "SELECT * FROM test_results WHERE scorecard_id = $1 "
%%     "ORDER BY test_id ASC, created_at DESC".

%% results_q() ->
%%     "SELECT * FROM test_results WHERE test_id = $1 "
%%     "ORDER BY created_at DESC".
