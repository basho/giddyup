%% @doc SQL worker process wrapper and queries/updates
-module(giddyup_sql).
-compile({inline, [projects_q/0, project_id_q/0, suite_q/0, scorecards_q/0]}).

-include_lib("epgsql/include/pgsql.hrl").

-define(QUERY(Q), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q) end)).
-define(QUERY(Q, F), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q, F) end)).

-export([
         start_link/1,
         extract_column_names/1
         ]).

-export([
         projects/0,
         project_exists/1,
         suite/3,
         scorecards/1
        ]).

%%---------------------
%% Process mgmt
%%---------------------
start_link(Args) ->
    %% TODO: make this a proper wrapper, prepare statements
    erlang:apply(pgsql, connect, Args).

extract_column_names(Columns) ->
    [ Name || #column{name=Name} <- Columns ].

%%---------------------
%% Query calls
%%---------------------
projects() ->
    ?QUERY(projects_q()).

project_exists(Name) ->
    ?QUERY(project_id_q(), [Name]).

suite(ProjectID, Platform, Version) ->
    ?QUERY(suite_q(), [ProjectID, Platform, Version]).

scorecards(ProjectID) ->
    ?QUERY(scorecards_q(), [ProjectID]).

%%---------------------
%% Query statement defs
%%---------------------

%% test_result_i() ->
%%     "INSERT INTO test_results (test_id, scorecard_id, long_version, status, created_at, updated_at) "
%%     "VALUES ($1, $2, $3, $4, NOW(), NOW()) "
%%     "RETURNING id".

%% artifact_i() ->
%%     "INSERT INTO artifacts (test_result_id, url, content_type, created_at, updated_at) "
%%     "VALUES ($1, $2, $3, NOW(), NOW()) "
%%     "RETURNING id".

projects_q() ->
    "SELECT id, name FROM projects".

project_id_q() ->
    "SELECT id, name FROM projects WHERE name = $1".

scorecards_q() ->
    "SELECT scorecards.id, scorecards.name FROM scorecards, projects "
    "WHERE projects.id = scorecards.project_id AND projects.name = $1"
    "ORDER BY scorecards.name DESC".

suite_q() ->
    "SELECT tests.* FROM tests, projects_tests "
    "WHERE tests.id = projects_tests.test_id"
    "   AND projects_tests.project_id = $1"
    "   AND platform = $2"
    "   AND (tests.min_version IS NULL OR tests.min_version <= $3)"
    "   AND (tests.max_version IS NULL OR tests.max_version >= $3) "
    "ORDER BY name, backend, upgrade_version".

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
