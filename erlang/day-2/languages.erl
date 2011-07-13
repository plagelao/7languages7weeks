-module(languages).
-export([description/2]).

description(List, SelectedLanguage) -> [{_, Description}|_] = lists:filter(fun({Language, _}) -> Language == SelectedLanguage end, List), Description.
