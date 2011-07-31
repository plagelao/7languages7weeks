---
layout: post
categories:
  - haskell
---
Great second Haskell day! We learnt about higher-order functions, anonymous functions, partially applied functions, function composition and lazy evaluation. All those concepts are incredible powerful and really easy to understand. If you want to see some of Haskell beauty, follow me through the exercises:

- Write a sort that takes a list and returns a sorted list.

  My solution for the sort methods is both complicated and inefficient :( Haskell already has a sort function, so you better use that one :D

        module Main where
          mySort :: [Integer] -> [Integer]
          mySort list
            | list == []    = []
            | t == []       = list
            | tail t == []  = sortTwoNumbers h (head t)
            | otherwise     = if areOrdered h t then h:(mySort t) else (head (mySort t)):mySort((h:(tail (mySort t))))
              where h = head list
                t = tail list
                areOrdered number list =  number > (head (mySort list))
                sortTwoNumbers x y = if x > y then [x,y] else [y,x]

  We order the tail of the list and then compare the head of the ordered tail with the head of the original list. If they are already ordered, we concatenate head and tail. If they are not ordered, we set the head of the ordered tail as the new head, and we concatenate it with the sortened "head + sorted tail" list.

- Write a sort that takes a list and a function that compares its two arguments and then returns a sorted list.

  We are going to use the algorithm from the first exercise, but we are going to use a function to set the order method:

        module Main where
          mySortWithFunction list fun
            | list == []    = []
            | t == []       = list
            | tail t == []  = sortTwoNumbers h (head t)
            | otherwise     = if areOrdered h t then h:(orderWithFun t) else (head(orderWithFun t)):orderWithFun((h:(tail(orderWithFun t))))
              where h = head list
                    t = tail list
                    areOrdered number list = fun number (head (orderWithFun list))
                    sortTwoNumbers x y = if fun x y then [x,y] else [y,x]
                    orderWithFun list = mySortWithFunction list fun

  Now, we accept a list and a function, and, instead of using the (%gt;) function to sort the list, we use the function provided by the user.

- Write a Haskell function to convert a string to a number. The string should be in the form of $2,345,678.99 and can possibly have leading zeros.

  We use filter to remove the ',' characters:

        module Main where
          toNumber (h:t) = read (filter (/= ',') t) :: Double

  Then, we use read to read to convert the string to double.

- Write a function that takes an argument x and returns a lazy sequence that has every third number, starting with x. Then, write a function that includes every fifth number, beginning with y. Combine these functions through composition to return every eighth number, beginning with x + y.

  This one is easy, but it shows the power of lazy loading:

        module Main where
          everyThirdNumber x = x:(everyThirdNumber (x+3))
          everyFifthNumber y = y:(everyFifthNumber (y+5))
          everyEighthNumber x y = zipWith (+) (everyThirdNumber x) (everyFifthNumber y)

  We use zipWith with the function + to mix the both sequences. This works because of the lazy evaluation. We use those function as follows:

        take 5 (everyEightnumber 1 5)
        -> [6,14,22,30,38]

  If we call the function without take, it will never stop running :D

        everyEightnumber 1 5
        -> tons of results

- Use a partially applied function to define a function that will return half of a number and another that will append \n to the end of any string.

  I love this one:

        module Main where
          division y x = x / y
          half = division 2

          append tail string = string ++ tail
          appendEndOfLine = append "\n"

  Now we can use half as follows:

        half 4
        -> 2

This is only the first part of day two. There is another set of exercises (kata style) and I will post them later this week. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/haskell/day-2).

See you later!
