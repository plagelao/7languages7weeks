---
layout: post
categories:
  - clojure
---
Day two with Clojure and I am not as excited as I thought I was going to be... The day starts with the bad news, Clojure (the JVM?) does not support tail recursion optimization, so it provide a complex syntax form to do it yourself. I am really new in functional programming, but tail recursion seems to be something very important. Maybe invoke dynamic can fix that?

Then, we learn about sequences and lazy sequences. I find lazy sequences something quite useful, although I need to get use to it.

After that, we learn some Clojure object orientation features. They map (more or less) interfaces and classes in java. Again. I am not very sure about how it fits in functional programming. Seems a little bit weird.

The day finishes with a very cool thing, macros. We can change the language using them, so we must be careful when using them. Let's have a look at the exercises to apply what we have learned.

- Implement an unless with an else condition using macros

  The author does an unless without else as an example in the book, so this is not a very difficult exercise:

        (defmacro unless [test body else-body]
          (list 'if (list 'not test) body else-body))

  Now, let me explain this a little bit. The syntax is very similar to the one used to define a function except that we are using defmacro to define the macro and we are using quote symbols in some places in the code. Where do we use a quote symbol? Every time we want to delay the execution of the function that follows the quote. So, in this case, we use ' to delay the execution of the if and the not, so they do not execute during the macro definition. And that is all, we have extended the language syntax with little effort :D Very cool!

- Write a type using defrecord that implements a protocol

  Ok, first of all, I do not like protocols and types in Clojure. As I said before, the whole idea seems a little weird, and it does not get better after using it:

        (defprotocol DoNotLikeProtocols
          (rant [d]))

  First, we define a protocol (similar to a Java interface). Then, we define a type that implements that protocol:

        (defrecord Troll []
          DoNotLikeProtocols
            (rant [_] "Why?"))

  And now we want to use that type in a program:

        (deftest type-and-protocol
          (is (= "Why?" (rant (Troll.)))))

  But this does not work. It says something like "unable to resolve class Troll" (by the way, the errors that Clojure throws have not been very helpful. This is the better one I have found so far :D). As I read [here](http://stackoverflow.com/questions/4580462/cant-import-clojure-records), you need to require that class in your program. That is weird, because I am already using the namespace where the class is defined. Anyway, I do not understand the problem very well (and I do not really care that much at the moment), so I end up defining a constructor function (as the link says):

        (defn troll [] (Troll.))

  So my test looks like:

        (deftest type-and-protocol
          (is (= "Why?" (rant (troll)))))

  And it works.

And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/clojure/day-2).

See you tomorrow!

