-module(giddyup).
-export([start/0,
         isotime/1]).

start() ->
    _ = [ application:start(Dep) || Dep <- resolve_deps(giddyup),
                                    not is_otp_base_app(Dep) ],
    ok.

dep_apps(App) ->
    application:load(App),
    {ok, Apps} = application:get_key(App, applications),
    Apps.

all_deps(App, Deps) ->
    [[ all_deps(Dep, [App|Deps]) || Dep <- dep_apps(App),
                                    not lists:member(Dep, Deps)], App].

resolve_deps(App) ->
    DepList = all_deps(App, []),
    {AppOrder, _} = lists:foldl(fun(A,{List,Set}) ->
                                        case sets:is_element(A, Set) of
                                            true ->
                                                {List, Set};
                                            false ->
                                                {List ++ [A], sets:add_element(A, Set)}
                                        end
                                end,
                                {[], sets:new()},
                                lists:flatten(DepList)),
    AppOrder.

is_otp_base_app(kernel) -> true;
is_otp_base_app(stdlib) -> true;
is_otp_base_app(_) -> false.

isotime({{Y,Mo,D},{H,Mi,S}}) ->
    ISO = io_lib:format("~w-~.2.0w-~.2.0wT~.2.0w:~.2.0w:~6.3.0fZ",
                        [Y, Mo, D, H, Mi, S]),
    unicode:characters_to_binary(ISO).
