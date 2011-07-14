-module(tictactoe).
-export([state/1]).


state(Board) ->
  case lists:any(fun(Cell) -> Cell == empty end, Board) of
    true -> no_winner;
    false -> winner(Board)
  end.

winner([C11,C12,C13,
        C21,C22,C23,
        C31,C32,C33]) ->
        Combinations = [[C11,C12,C13],[C21,C22,C23],[C31,C32,C33],
                        [C11,C21,C31],[C12,C22,C32],[C13,C23,C33],
                        [C11,C22,C33],[C13,C22,C31]],
        Solution = [Player || Player <- [x,o], Combination <- Combinations, lists:all(fun(Cell) -> Cell == Player end, Combination)],
        case Solution of
          [] -> cat;
          [Winner|_] -> Winner
        end.
