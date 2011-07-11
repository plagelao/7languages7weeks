-module(count).
-export([words/1]).
-export([to_ten/0]).

words([]) -> 0;
words([32|Rest]) -> words(Rest);
words([Character|[]]) -> 1;
words([Character|[32|Rest]]) -> 1 + words(Rest);
words([Character|Rest]) -> words(Rest).


to_ten() -> to_ten_from(1).
to_ten_from(10) -> io:format("Number : 10\n");
to_ten_from(Number) -> io:format("Number: " ++ integer_to_list(Number) ++ "\n"),to_ten_from(Number + 1).
