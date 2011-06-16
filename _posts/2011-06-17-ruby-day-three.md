---
layout: post
---
Metaprogramming is awesome! I have a great time everytime I do some metaprogramming in Ruby. Is that a problem? Well, it can be. I know that Ruby is Mary Poppins, but this quote from Spiderman fits better:

"With great power. comes great responsibility"

I think it is very easy to do more than enough metaprogramming. You need to be careful not to end up with a horrible mess...

There is one exercise for this day:

- Modify the CSV application to support an each method to return a CsvRow object. Use method_missing on that CsvRow to return the value for the column for a given heading.

You can see [my solution here](https://github.com/plagelao/7languages7weeks/blob/exercises/ruby/day-3/act_as_csv_module.rb).

The author does not say anything about it, but I think it is important to modify the respond_to? method if we use method_missing to add methods. As [Jim Weirich](https://twitter.com/#!/jimweirich) says, it is the polite way ;)

See you tomorrow!


