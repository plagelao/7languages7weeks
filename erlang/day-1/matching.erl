-module(matching).
-export([print/1]).

print(success) -> io:format("success\n");
print({error, Message}) -> io:format("error: " ++ Message ++ "\n").

