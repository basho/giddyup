%% -------------------------------------------------------------------
%%
%% Copyright (c) 2016 Basho Technologies, Inc.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(giddyup_wm_site).
-author("hazen").

%% API
-export([accept_site/4]).

accept_site(Archive, RD, TestResultID, ArtifactID) ->
    [File|_] = wrq:path_tokens(RD),
    [FName|_] = string:tokens(filename:basename(File), "."),
    Tmp = lists:flatten(io_lib:format("/tmp/~s-~p-~p", [FName, TestResultID, ArtifactID])),
    case Archive of
        tar ->
            erl_tar:extract({binary, wrq:req_body(RD)}, [compressed, {cwd, Tmp}]);
        zip ->
            zip:extract(wrq:req_body(RD), [{cwd, Tmp}])
    end,
    UploadFun =
        fun(FileName, Acc) ->
            {ok, Binary} = file:read_file(FileName),
            ThisFile = FileName -- Tmp,
            Mime =  mime_type(filename:extension(FileName)),
            Key = lists:flatten(io_lib:format("~b~s", [TestResultID, ThisFile])),
            {_H, _B} = giddyup_artifact:upload(Key, Mime, Binary),
            case Mime of
                "text/html" -> [Key|Acc];
                _ -> Acc
            end
        end,
    Files = filelib:fold_files(Tmp, ".*", true, UploadFun, []),
    case Files of
        [] -> throw(no_index_html);
        _ ->
            %% Find the highest level .html file
            Index = hd(lists:sort(fun(A, B) -> length(A) < length(B) end, Files)),
            URL = giddyup_artifact:url_for(Index),
            os:cmd("rm -Rf " ++ Tmp),
            {ok, _} = giddyup_sql:create_artifact(ArtifactID, TestResultID, URL, "text/html")
    end.

mime_type(".html") ->
    "text/html";
mime_type(".js") ->
    "application/javascript";
mime_type(".css") ->
    "text/css";
mime_type(".log") ->
    "text/plain";
mime_type(".summary") ->
    "text/plain";
mime_type("") ->
    "binary/octet-stream";
mime_type(_) ->
    "text/plain".
