---
layout: post
categories:
  - haskell
---
This weeks language is Haskell. I have already read the whole chapter and all I have to say is that I love Haskell. Obviously, I still do not now almost anything about it (one week is not enough), but this was a very fun week. Anyway, I have only done the exercises for the first day, so I will continue with my one post per day series.

In day one we only see the basics (some of the syntax, pattern matching, guards and lazy sequences), so let's have a look at the exercises to explain those basic concepts:

- How many different ways can you find to write allEven? (allEven is a function that returns a list with the even numbers from another list)

  This is a very simple example, but it can help us to understand the syntax and how lists work. The solution from the book is:

        module Main where
          allEven :: [Integer] -> [Integer]
          allEven [] = []
          allEven (h:t) = if even h then h:allEven t else allEven t

  The first line is telling Haskell that we are going to add something to the Main module (the top-level module in Haskell). Then, we declare the signature of the function. Haskell is a strong typed language, but it is not mandatory to explicitly declare the types that your function accepts or returns, Haskell can infer them. In this case, we want to be explicit, so we declare that our function only accepts lists of integers and returns a list of integers.
  Before we continue, I have to say that Haskell type system is really great. We learnt a little bit more about it on the third day and it seems to be really powerful. Also, the errors that Haskell throws at compile time are really useful and helpful, which is something great when you are starting to learn a new language :D
  Let's go back to the example. The next line says that if we want the even elements of an empty list we are going to get an empty list. Then, we use pattern matching to get the even elements of a non empty list. We decomposed the list in head and tail and we create a new list with head (if it is empty) followed by the all even numbers in the tail of the original list (we are using recursion as we always, almost, do in FP).
  Another solution can be:

        allEven :: [Integer] -> [Integer]
        allEven(list) = [ x | x <- list, even x]

  We are using list comprehension to get only the even numbers in the list. And, finally, we can filter the list with an even filter:

        allEven :: [Integer] -> [Integer]
        allEven(list) = filter (\x -> even x) list

- Write a function that takes a list and returns the same list in reverse.

  In this case, we are not going to say anything about the type of the elements in the list, but we want to ensure that this function is only called with lists:

        module Main where
          myReverse :: [a] -> [a]
          myReverse [] = []
          myReverse(h:t) = myReverse(t) ++ [h]

  Then, we are concatenating the head with the reversed tail.

- Write a function that builds two-tuples with all possible combinations of two of the colors black, white, blue, yellow, and red. Note that you should include only one of (black, blue) and (blue, black).

  This example is already done in the book with an Start Trek crew example. We use list comprehension to achieve our goal:

        module Main where
          colorCombinations = [(aColor, anotherColor) | aColor <- ["black","white","blue","yellow","red"],
                                                        anotherColor <- ["black","white","blue","yellow","red"],
                                                        aColor > anotherColor]

- Write a list comprehension to build a childhood multiplication table. The table would be a list of three-tuples where the first two are integers from 1-12 and the third is the product of the first two.

  We are going to use Haskell ranges to do this exercise:

        module Main where
          multiplicationTable = [(x,y,x*y) | x <- [1..12], y <- [1..12]]

  And that is all. With that tiny thing we get the multiplication table :D

- Solve the map-coloring problem using Haskell.

  The map-coloring problem is the one where we have a map and we want to color all the states/countries with the minimum set of colors but we do not want any neighbour to share the color.
  It took me a long time to solve this exercise, what proofs that I do not understand the functional programming paradigm as well as I thought :D Also, I used some of the concepts from day two to make the code more readable. Let's have a look:

        module Main where
          states = ["Tenesse", "Missisipi", "Alabama", "Georgia", "Florida"]
          borders = [["Missisipi", "Alabama", "Georgia"], ["Tenesse", "Alabama"], ["Tenesse", "Missisipi", "Georgia", "Florida"], ["Tenesse", "Alabama", "Florida"], ["Georgia", "Alabama"]]
          statesAndBorders = zip states borders

  We declared the states and their borders, then, we use zip to build tuples with the state and it borders.

          paintMap ((state,neighbours):states) colors coloredStates
            | states == []    = [paintState]
            | otherwise       = paintState:paintMap states colors (paintState:coloredStates)
                where paintState                   = (state, head colorsNotUsedByNeighbours)
                      colorsNotUsedByNeighbours = [ color | color <- colors, isAFreeColor color]
                      isAFreeColor color         = all (\usedColor -> usedColor /= color) usedColorsInNeighbours
                      usedColorsInNeighbours     = [ color | (state, color) <- coloredStates, isNeighbour state]
                      isNeighbour coloredState    = any (\neighbour -> coloredState == neighbour) neighbours

  Then, we paint the map. The paintMap function gets three arguments, the states (with their borders) to paint, the colors we can use to paint them, and the states already colored (name and color). If we only need to paint one state we just paint that state. Otherwise we paint the head state from the list of states to paint and paint a map without that state in the to paint states (but inside the already colored states). We use a guard to see if we only need to paint one state or more than one. Also, we use the where clause to declare all the helper functions that paintMap needs. You can have a look at those functions, they use list comprehensions, pattern matching, anonymous function, etc. We will talk about anonymous function tomorrow).
  Finally, we use paintMap function with the map that we defined before, with the colors that the user want and with an empty list of colored states:

          colorMap colors = paintMap statesAndBorders colors []


And that's all for today. I am really enjoying Haskell and I am looking forward to tomorrow exercises. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/haskell/day-1).

See you tomorrow!
