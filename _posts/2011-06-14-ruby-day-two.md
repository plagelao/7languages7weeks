---
layout: post
---

Someone told me once that, in order to master a language, you must learn everything about how collections work in that language. Bruce A. Tate seems to agree with that, since Ruby second day is all about collections (ok, and blocks).

There are only two classes for collections in ruby, [Array](http://www.ruby-doc.org/core/classes/Array.html) and [Hash]()http://www.ruby-doc.org/core/classes/Hash.html. Both of them are [Enumerable(s)](http://www.ruby-doc.org/core/classes/Enumerable.html) and both of them are awesome. You can do great things with them in a very easy way.

There are three exercises for this day:

- Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now, do the same with each_slice in Enumerable.
- The Tree class (plagelao: It is an example of the book) was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {'grandpa' => {'dad' => {'child_1' => {}, 'child_2' => {}}, 'uncle' => {'child_3 => {}, 'child_4' => {}}}}
  (plagelao: I don't particularly like this user interface, but it is better than the first one, believe me)
-Write a simple grep that will print the lines of a file having any ocurrences of a phrase anywhere in that line. If you want, include the line numbers.

You can see [my solutions here](https://github.com/plagelao/7languages7weeks/tree/exercises/ruby/day-2)

See you tomorrow!

