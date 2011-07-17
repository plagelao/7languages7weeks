-module(zombie).
-export([experiment/0]).

experiment() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("The translator is alive!~n"),
      register(translator, spawn_link(fun translator:loop/0)),
      experiment();

    {'EXIT', From, Reason} ->
      case Reason of
        translator ->
          io:format("The process ~p killed the translator ~n", [From]),
          io:format("Let's create life~n"),
          self() ! new,
          experiment();
        doctor ->
          io:format("The process ~p killed the doctor ~n", [From]),
          io:format("The doctor is a zombie now!~n"),
          exit(whereis(translator), translator),
          Zombie = spawn(fun zombie:experiment/0),
          Zombie ! new
      end
  end.

