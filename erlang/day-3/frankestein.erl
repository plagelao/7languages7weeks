-module(frankestein).
-export([experiment/0]).

experiment() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("It's alive!~n"),
      register(translator, spawn_link(fun translator:loop/0)),
      experiment();
    {'EXIT', From, Reason} ->
      io:format("The translator ~p died: ~p ~n", [From, Reason]),
      io:format("Let's create life~n"),
      self() ! new,
      experiment()
  end.
