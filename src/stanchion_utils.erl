%% -------------------------------------------------------------------
%%
%% Copyright (c) 2007-2012 Basho Technologies, Inc.  All Rights Reserved.
%%
%% -------------------------------------------------------------------

%% @doc stanchion utility functions

-module(stanchion_utils).

%% Public API
-export([get_admin_creds/0]).

%% @doc Return the credentials of the admin user
-spec get_admin_creds() -> {ok, {string(), string()}} | {error, term()}.
get_admin_creds() ->
    case application:get_env(stanchion, admin_key) of
        {ok, KeyId} ->
            case application:get_env(stanchion, admin_secret) of
                {ok, Secret} ->
                    {ok, {KeyId, Secret}};
                undefined ->
                    _ = lager:warning("The admin user's secret has not been defined."),
                    {error, secret_undefined}
            end;
        undefined ->
            _ = lager:warning("The admin user's key id has not been defined."),
            {error, key_id_undefined}
    end.
