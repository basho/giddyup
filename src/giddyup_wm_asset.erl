%% @doc Serves static files
-module(giddyup_wm_asset).

-export([init/1,
         routes/0,
         to_resource/2,
         allowed_methods/2,
         generate_etag/2,
         last_modified/2,
         resource_exists/2,
         encodings_provided/2,
         content_types_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").
-include_lib("kernel/include/file.hrl").

-record(context, {filename,
                  fileinfo}).

%% @doc Initialize the resource.
-spec init([]) -> {ok, #context{}}.
init([]) ->
    {ok, #context{}}.

%% @doc Return the routes this module should respond to.
-spec routes() -> [webmachine_dispatcher:matchterm()].
routes() ->
    [{[""], ?MODULE, []}, {['*'], ?MODULE, []}].

%% @doc Handle serving of the single page application.
-spec allowed_methods(wrq:reqdata(), #context{}) ->
    {list(), wrq:reqdata(), #context{}}.
allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

%% @doc Generates an etag for the asset being served.
-spec generate_etag(wrq:reqdata(), #context{}) ->
                           {list(), wrq:reqdata(), #context{}}.
generate_etag(ReqData, #context{fileinfo={ok, #file_info{inode=Inode, mode=Mode, mtime=MTime}}}=Context) ->
    {mochihex:to_hex(crypto:hash(sha, term_to_binary([Inode, Mode, MTime]))), ReqData, Context};
generate_etag(ReqData, Context) ->
    {undefined, ReqData, Context}.


%% @doc Determines the time the asset was last modified
-spec last_modified(wrq:reqdata(), #context{}) ->
                           {undefined | calendar:datetime(),
                            wrq:reqdata(), #context{}}.
last_modified(ReqData, #context{fileinfo={ok, #file_info{mtime=MTime}}}=Context) ->
    {MTime, ReqData, Context};
last_modified(RD, Context) ->
    {undefined, RD, Context}.

encodings_provided(RD, Context) ->
    {[{"identity", fun(X) -> X end},
      {"gzip", fun zlib:gzip/1},
      {"deflate", fun zlib:zip/1}], RD, Context}.


%% @doc Given a series of request tokens, normalize to priv dir file.
-spec normalize_filepath(list()) -> list().
normalize_filepath(Filepath) ->
    {ok, App} = application:get_application(?MODULE),
    filename:join([priv_dir(App), "www"] ++ Filepath).

%% @doc Return a context which determines if we serve up the index or a
%%      particular file
-spec identify_resource(wrq:reqdata(), #context{}) ->
    {boolean(), #context{}}.
identify_resource(ReqData, #context{filename=undefined}=Context) ->
    Tokens = case wrq:disp_path(ReqData) of
                 "" -> ["index.html"];
                 _  -> wrq:path_tokens(ReqData)
             end,
    Filename = normalize_filepath(Tokens),
    FileInfo = file:read_file_info(Filename),
    {true, Context#context{filename=Filename,
                           fileinfo=FileInfo}};
identify_resource(_ReqData, Context) ->
    {true, Context}.

%% @doc If the file exists, allow it through, otherwise assume true if
%%      they are asking for the application template.
-spec resource_exists(wrq:reqdata(), #context{}) ->
    {boolean(), wrq:reqdata(), #context{}}.
resource_exists(ReqData, Context) ->
    {true, NewContext=#context{filename=Filename}} = identify_resource(ReqData, Context),
    case filelib:is_regular(Filename) of
        true ->
            {true, ReqData, NewContext};
        _ ->
            {false, ReqData, NewContext}
    end.

%% @doc Return the proper content type of the file, or default to
%%      text/html.
-spec content_types_provided(wrq:reqdata(), #context{}) ->
    {list({list(), atom()}), wrq:reqdata(), #context{}}.
content_types_provided(ReqData, Context) ->
    case identify_resource(ReqData, Context) of
        {true, NewContext=#context{filename=Filename}} ->
            MimeType = webmachine_util:guess_mime(Filename),
            {[{MimeType, to_resource}], ReqData, NewContext};
        {true, NewContext} ->
            {[{"text/html", to_resource}], ReqData, NewContext}
    end.

%% @doc Return the resources content.
-spec to_resource(wrq:reqdata(), #context{}) ->
    {binary(), wrq:reqdata(), #context{}}.
to_resource(ReqData, #context{filename=Filename}=Context) ->
    {ok, Source} = file:read_file(Filename),
    {Source, ReqData, Context}.

%% @doc Extract the priv dir for the application.
-spec priv_dir(term()) -> list().
priv_dir(Mod) ->
    case code:priv_dir(Mod) of
        {error, bad_name} ->
            Ebin = filename:dirname(code:which(Mod)),
            filename:join(filename:dirname(Ebin), "priv");
        PrivDir ->
            PrivDir
    end.
