%% @doc SQL worker process wrapper and queries/updates
-module(giddyup_sql).

%% Inline all the query strings, they're basically constants.
-compile({inline, [
                   artifact_i/0,
                   artifacts_q/0,
                   full_matrix_q/0,
                   project_id_q/0,
                   projects_q/0,
                   scorecard_by_version_q/0,
                   scorecard_i/0,
                   scorecard_id_q/0,
                   scorecards_q/0,
                   suite_q/0,
                   test_result_i/0
                  ]}).

-include_lib("epgsql/include/pgsql.hrl").

-define(QUERY(Q), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q) end)).
-define(QUERY(Q, F), poolboy:transaction(?MODULE, fun(C) -> pgsql:equery(C, Q, F) end)).

-export([
         start_link/1,
         extract_column_names/1
         ]).

-export([
         artifacts/1,
         create_artifact/3,
         create_scorecard/2,
         create_test_result/5,
         full_matrix/1,
         next_id/1,
         project_exists/1,
         projects/0,
         q/1,
         q/2,
         scorecard_exists/1,
         scorecards/1,
         suite/3
        ]).

%%---------------------
%% Process mgmt
%%---------------------
start_link(Args) ->
    %% TODO: make this a proper wrapper, prepare statements
    erlang:apply(pgsql, connect, Args).

%%---------------------
%% Queries
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

scorecards(ProjectID) ->
    ?QUERY(scorecards_q(), [ProjectID]).

full_matrix(ScorecardID) ->
    ?QUERY(full_matrix_q(), [ScorecardID]).

artifacts(TestResultID) ->
    ?QUERY(artifacts_q(), [TestResultID]).

%%-----------------------------------------
%% Riak Test endpoints - suites and results
%%-----------------------------------------

suite(ProjectID, Platform, Version) ->
    ?QUERY(suite_q(), [ProjectID, Platform, Version]).

next_id(Table) when is_list(Table) ->
    SeqName = Table ++ "_id_seq",
    ?QUERY("SELECT nextval($1)", [SeqName]).

create_artifact(TestResultID, URL, CType) ->
    ?QUERY(artifact_i(), [TestResultID, URL, CType]).

create_test_result(ID, TID, SID, V, St) ->
    ?QUERY(test_result_i(), [ID, TID, SID, V, St]).

create_scorecard(ProjectID, Version0) ->
    Version = giddyup_version:parse(Version0),
    case try_create_scorecard(ProjectID, Version) of
        {rollback, Result} -> Result;
        Result -> Result
    end.

try_create_scorecard(ProjectID, Version) ->
    transaction(
      fun(C) -> try_create_scorecard1(C, ProjectID, Version)
      end).

try_create_scorecard1(C, ProjectID, Version) ->
    case pgsql:equery(C, scorecard_by_version_q(), [ProjectID, Version]) of
        {ok, _, []} ->
            pgsql:equery(C, scorecard_i(), [ProjectID, Version]);
        Result ->
            Result
    end.

transaction(Fun) ->
    poolboy:transaction(?MODULE, fun(C) -> pgsql:with_transaction(C, Fun) end).

%%---------------------
%% Utilities
%%---------------------

extract_column_names(Columns) ->
    [ Name || #column{name=Name} <- Columns ].

%%---------------------
%% SQL statement defs
%%---------------------

test_result_i() ->
    "INSERT INTO test_results (id, test_id, scorecard_id, long_version, status, created_at, updated_at) "
    "VALUES ($1, $2, $3, $4, $5, NOW(), NOW())".

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
    "SELECT tests.id AS test_id, tests.name, platform, backend, upgrade_version, multi_config"
    "       test_results.id AS result_id, status, long_version, test_results.created_at "
    "FROM scorecards, projects_tests, tests LEFT OUTER JOIN test_results "
    "   ON (tests.id = test_results.test_id AND test_results.scorecard_id = $1) "
    "WHERE scorecards.id = $1 "
    "   AND projects_tests.project_id = scorecards.project_id "
    "   AND projects_tests.test_id = tests.id "
    "   AND (tests.min_version IS NULL OR tests.min_version <= scorecards.name) "
    "   AND (tests.max_version IS NULL OR tests.max_version >= scorecards.name) "
    "ORDER BY tests.name, platform, backend, upgrade_version, multi_config, tests.id, test_results.created_at DESC".

artifacts_q() ->
    "SELECT id, url, content_type, created_at "
    "FROM artifacts "
    "WHERE test_result_id = $1 "
    "ORDER BY created_at DESC".

scorecard_by_version_q() ->
    "SELECT id FROM scorecards WHERE project_id = $1 AND name = $2".

scorecard_i() ->
    "INSERT INTO scorecards (project_id, name) VALUES ($1, $2) RETURNING id".
