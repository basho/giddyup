%% @doc SQL worker process wrapper and queries/updates
-module(giddyup_sql).
-compile({inline, [projects_q/0,
                   project_id_q/0,
                   suite_q/0,
                   scorecards_q/0,
                   full_matrix_q/0,
                   artifacts_q/0]}).

-include_lib("epgsql/include/pgsql.hrl").

-define(QUERY(Q), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q) end)).
-define(QUERY(Q, F), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q, F) end)).

-export([
         start_link/1,
         extract_column_names/1
         ]).

-export([
         q/1,
         q/2,
         projects/0,
         project_exists/1,
         suite/3,
         scorecards/1,
         scorecard_exists/1,
         %% matrix/1,
         full_matrix/1,
         artifacts/1,
         create_artifact/3
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
q(SQL) ->
    ?QUERY(SQL).

q(SQL, Params) ->
    ?QUERY(SQL, Params).

projects() ->
    ?QUERY(projects_q()).

project_exists(Name) ->
    ?QUERY(project_id_q(), [Name]).

scorecard_exists(ID) ->
    case ?QUERY(scorecard_id_q(), [ID]) of
        %%
        {ok, _, [_]} ->
            true;
        _ ->
            false
    end.

suite(ProjectID, Platform, Version) ->
    ?QUERY(suite_q(), [ProjectID, Platform, Version]).

scorecards(ProjectID) ->
    ?QUERY(scorecards_q(), [ProjectID]).

%% matrix(ScorecardID) ->
%%     ?QUERY(matrix_q(), [ScorecardID]).

full_matrix(ScorecardID) ->
    ?QUERY(full_matrix_q(), [ScorecardID]).

artifacts(TestResultID) ->
    ?QUERY(artifacts_q(), [TestResultID]).

create_artifact(TestResultID, URL, CType) ->
    ?QUERY(artifact_i(), [TestResultID, URL, CType]).

%%---------------------
%% Query statement defs
%%---------------------

%% test_result_i() ->
%%     "INSERT INTO test_results (test_id, scorecard_id, long_version, status, created_at, updated_at) "
%%     "VALUES ($1, $2, $3, $4, NOW(), NOW()) "
%%     "RETURNING id".

artifact_i() ->
    "INSERT INTO artifacts (test_result_id, url, content_type, created_at, updated_at) "
    "VALUES ($1, $2, $3, NOW(), NOW()) "
    "RETURNING id".

projects_q() ->
    "SELECT id, name FROM projects".

project_id_q() ->
    "SELECT id, name FROM projects WHERE name = $1".

scorecards_q() ->
    "SELECT scorecards.id, scorecards.name FROM scorecards, projects "
    "WHERE projects.id = scorecards.project_id AND projects.name = $1"
    "ORDER BY scorecards.name DESC".

scorecard_id_q() ->
    "SELECT 't'::bool FROM scorecards WHERE scorecards.id = $1".

suite_q() ->
    "SELECT tests.* FROM tests, projects_tests "
    "WHERE tests.id = projects_tests.test_id"
    "   AND projects_tests.project_id = $1"
    "   AND platform = $2"
    "   AND (tests.min_version IS NULL OR tests.min_version <= $3)"
    "   AND (tests.max_version IS NULL OR tests.max_version >= $3) "
    "ORDER BY name, backend, upgrade_version".

%% matrix_q() ->
%%     "SELECT tests.* "
%%     "FROM scorecards, projects_tests, tests "
%%     "WHERE scorecards.id = $1 "
%%     "   AND projects_tests.project_id = scorecards.project_id "
%%     "   AND projects_tests.test_id = tests.id "
%%     "   AND (tests.min_version IS NULL OR tests.min_version <= scorecards.name) "
%%     "   AND (tests.max_version IS NULL OR tests.max_version >= scorecards.name) "
%%     "ORDER BY name, platform, backend, upgrade_version".

full_matrix_q() ->
    "SELECT tests.id AS test_id, tests.name, platform, backend, upgrade_version, "
    "       test_results.id AS result_id, status, long_version, test_results.created_at "
    "FROM scorecards, projects_tests, tests LEFT OUTER JOIN test_results "
    "   ON (tests.id = test_results.test_id AND test_results.scorecard_id = $1) "
    "WHERE scorecards.id = $1 "
    "   AND projects_tests.project_id = scorecards.project_id "
    "   AND projects_tests.test_id = tests.id "
    "   AND (tests.min_version IS NULL OR tests.min_version <= scorecards.name) "
    "   AND (tests.max_version IS NULL OR tests.max_version >= scorecards.name) "
    "ORDER BY tests.name, platform, backend, upgrade_version, test_results.created_at DESC".

artifacts_q() ->
    "SELECT id, url, content_type, created_at "
    "FROM artifacts "
    "WHERE test_result_id = $1 "
    "ORDER BY created_at DESC".
