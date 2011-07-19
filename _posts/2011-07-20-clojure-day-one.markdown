---
layout: post
categories:
  - clojure
---
This weeks language is Clojure. I am studying the SICP book, which uses scheme, so I already knew a little bit of Lisp (just a little bit). Anyway, I really want to learn Clojure because I think it is a language I can use in production sooner than later.

So, this first day shows us the syntax basics and the collections, as we are going to see in the exercises:

- Implement a function called (big st n) that returns true if a string st is longer than n characters.

  My solution here:

        (defn big [str n] (> (count str) n))

  It is very simple, but it shows us how to define a function in Clojure. First of all, we use the word defn. Then, we specify the parameters for the function with a vector (the thing with the square brackets). Finally, we specify the body of the function.
  The same function in scheme:

        (define big str n (> (count str) n))

  Tiny differences.

- Write a function called (collection-type col) that returns :list, :map or :vector based on the type of collection col.

  Here we can see a reminder of the JVM:

        (defn collection-type [col]
          (cond (= clojure.lang.PersistentList (class col)) :list
                (= clojure.lang.PersistentArrayMap (class col)) :map
                (= clojure.lang.PersistentVector (class col)) :vector))


And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/clojure/day-1). Now, with 100% more of tests!

See you tomorrow!
