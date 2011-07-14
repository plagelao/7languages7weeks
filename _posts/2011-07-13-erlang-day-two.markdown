---
layout: post
categories:
  - erlang
---
What a great second day! I am starting to love functional programming :) Also, I really like the Prolog in Erlang, it seems like a really fun language.

I think that the most important thing we learned today is this crazy thing called list comprehension. At first, I found it syntax weird and ugly, but once I started using it (there is an exercise later that uses it) I changed my mind. It is really beautiful! (and powerful).

There is one thing in Erlang that I have not got use to yet, though. It is not easy to start every variable name with an uppercase letter :P

Let's have a look at today exercises so you can also appreciate Erlang beauty:

- Consider a list of keyword-value tuples, such as [{erlang, "a functional language"}, {ruby, "an OO language"}]. Write a function that accepts the list and a keyword and returns the associated value for the keyword.

  I could have create the function as anonymous one, but I preferred to define it in a file:
        -module(languages).
        -export([description/2]).

        description(List, SelectedLanguage) -> [{_, Description}|_] = lists:filter(fun({Language, _}) -> Language == SelectedLanguage end, List), Description.

  We are applying a filter function on the list to get the value that we want and then we return the Description part of the selected tuple.
  It is almost like Prolog. The most important difference is that this Erlang function returns a value (Description), something that we were not allowed to do in Prolog.

- Consider a shopping list that looks like [{item, quantity, price},...]. Write a list comprehension that builds a list of items of the form [{item, total_price},...], where total_price is quantity times price.

  So, imagine we have the following shopping list:

        ShoppingList = [{apples, 4, 0.3},{oranges, 3, 0.6},{ cherries, 10, 0.04}].

  If we want to transform that list in a item-total_price list all we need to do is:

        [{Item, Quantity * Price} || {Item, Quantity, Price} <- ShoppingList].

  And we are going to get:

        [{apples, 1.2}, {oranges, 1.8}, {cherries, 0.4}].

  Did you see that? We transform the data form one form to another in a very simple and expressive way. How awesome is that?

- Bonus problem: Write a problem that reads a tic-tac-toe board presented as a list or a tuple of size nine. Return the winner (x or y) if a winner has been determined, cat if there are no more possible moves, or no_winner if no player has won yet.

  This exercise shows a little bit of Erlang power (in the hands of a noob). I use case and list comprehension to do this:

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

  How cool is that? So many things done in so little code! And I think it is readable, too. What do you think?
  I am sure that there is a better solution to the exercise, but I am very happy with this one (I blame Erlang).

  And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/erlang/day-2). See you tomorrow!
