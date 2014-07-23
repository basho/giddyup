%% @doc After coverage report generated, this resource shoves it out.
-module(giddyup_wm_coverage).

-record(context, {file}).

-export([
    init/1,
    routes/0,
    resource_exists/2,
    to_html/2
]).

-include("giddyup_wm_auth.hrl").

routes() ->
    [{["coverage", project, '*'], ?MODULE, []}].

init(_) ->
    {ok, #context{}}.

resource_exists(RD, Context) ->
    Project = wrq:path_info(project, RD),
    TailPath = wrq:disp_path(RD),
    LocalPath = filename:join(["tmp", "coverage", Project, TailPath]),
    lager:debug("coverage resource - Project: ~s, TailPath: ~p; LocalPath: ~p", [Project, TailPath, LocalPath]),
    {Boolean, File} = case filelib:is_dir(LocalPath) of
        true ->
            {true, filename:join(LocalPath, "index.html")};
        false ->
            case filelib:is_file(LocalPath) of
                false ->
                    {false, undefined};
                true ->
                    {true, LocalPath}
            end
    end,
    {Boolean, RD, Context#context{file = File}}.

to_html(RD, Context) ->
    File = Context#context.file,
    lager:debug("Spitting out contents of ~s", [File]),
    {ok, Binary} = file:read_file(File),
    {Binary, RD, Context}.

