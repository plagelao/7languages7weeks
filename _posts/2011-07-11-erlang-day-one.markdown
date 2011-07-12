---
layout: post
categories:
  - erlang
---
After skipping the scala week (I will do it when we finish the rest of the languages), I really want to start with this week language, Erlang.

Erlang is the first functional language that we study in the book. I am also studying [SICP](http://plagelao.github.com/SICP/), which uses Scheme (a Lisp dialect), because I want to learn how functional programming works. Given that, I am looking forward to knowing more about Erlang. Also, after reading the first day section I really like how Erlang works (Its similarities with Prolog makes Erlang very fun!).

Let's have a look at this first day exercises:

- Write a function that uses recursion nto return the number of words in a string.

  This exercise reminds me of Prolog:

        -module(count).
        -export([words/1]).

        words([]) -> 0;
        words([32|Rest]) -> words(Rest);
        words([_|[]]) -> 1;
        words([_|[32|Rest]]) -> 1 + words(Rest);
        words([_|Rest]) -> words(Rest).

  * Update: I changed the formula to remove some warnings :)

  I think that there should be a better solution, but this is mine :P The 32 is the ASCII code for an empty space. So, how am I counting words? First of all, in Erlang, a string is a list of characters, so my strategy is to count how many empty spaces are in that list (more or less). My first "rule" is that an empty string has no words. Then, if the string starts with an empty space, I remove that empty space and count the words for the rest of the string. Also, if the string is compoused by a single charater, it contains one word. If the string starts with a character followed by an empty space, we count the words in the rest of the string and add one more (the first one). Finally, if the first character is not followed by an empty space we removed that character and count the words in the rest of the string... Sounds complicated, doesn't it?

- Write a function that uses recursion to count to ten.

  This exercise is simpler than the other one:

        -module(count).
        -export([to_ten/0]).

        to_ten() -> to_ten_from(1).
        to_ten_from(10) -> io:format("Number : 10\n");
        to_ten_from(Number) -> io:format("Number: " ++ integer_to_list(Number) ++ "\n"),to_ten_from(Number + 1).

- Write a function that uses matching to selectively print "success" or "error: message" given input of the form {error, Message} or success.

  Again, this is a very simple exercises:

        -module(matching).
        -export([print/1]).

        print(success) -> io:format("success\n");
        print({error, Message}) -> io:format("error: " ++ Message ++ "\n").


And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/erlang/day-1). See you tomorrow!

