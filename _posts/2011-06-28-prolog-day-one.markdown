---
layout: post
categories:
  - prolog
---
New week, new language! This week is prolog's turn. I have not done any prolog before, so this is going to be fun.

Prolog is based in facts and rules. You have to define a set of facts and rules and then you can ask prolog about the "world" that you just created. It sounds really great, I create a world an then I ask the computer about it! Of course, that's how computers should behave. Prolog transforms your computer into an Oracle!

Ok, let's do some work and see if it is as cool as it sounds. Today, Bruce Tate asks us to do some "exercises", but it is not like the first two week:

- Make a simple knowledge base. Represent some of your favorite books and authors.

  What!? A simple knowledge base? Shouldn't I been looking how true or false is define, how to print "Hello world" or something similar? Shouldn't I been doing something? Nop, prolog does not work that way. Prolog basic stuff is how to create a knowledge base (and how to ask some questions about it, but that's for the next exercise).
  So, here it is, my library:

        book(dostoevski, crime_and_punishment).
        book(tolstoi, war_an_peace).
        book(gogol, dead_souls).
        book(keyes, flowers_for_algernon).
        book(borges, el_aleph).
        book(tolstoi, anna_karenina).

  It is not very big, but it is mine. Here, we are defining a knowledge base based only in facts. Every book(author, title) is a fact. Dostoievski wrote Crime and Punishment, Borges wrote El Aleph, etc.

- Find all books in your knowledge base written by one author.

  The first thing we need to do is load the library in prolog:

        GNU Prolog 1.3.1
        By Daniel Diaz
        Copyright (C) 1999-2009 Daniel Diaz
        | ?- ['prolog/day-1/library'].
        compiling /Users/plagelao/development/languages/7languages7weeks/prolog/day-1/library.pl for byte code...
        /Users/plagelao/development/languages/7languages7weeks/prolog/day-1/library.pl compiled, 6 lines read - 983 bytes written, 17 ms

        yes

  Great! Now prolog knows about our library. Let's ask it about all the books written by Tolstoi:

        | ?- book(tolstoi, Title).

        Title = war_an_peace ? a

        Title = anna_karenina

        yes

  Ok, but that was an easy one... Not too much magic here appart from the how we are asking for the books. If you didn't notice, the name of the author starts with a lowercase letter, and the title starts with an uppercase letter. Words starting with a lowercase letter are atoms (something like symbols in Ruby) and words starting with an uppercase are variables. Let's see another example. I want to know who wrote Dead souls:

        | ?- book(Who, dead_souls).

        Who = gogol ? a

        no

  Now the variable is Who (the author) and the title is an atom (dead_souls).

- Make a knowledge base representing musicians and instruments. Also represent musicians and their genre of music.

       musician(jota, guitar).
       musician(jota, vocals).
       musician(m_ward, guitar).
       musician(m_ward, vocals).
       musician(zooey, vocals).
       musician(eric, drum).
       musician(jarvis, vocals).
       musician(john, guitar).

       genre(jota, pop).
       genre(m_ward, folk).
       genre(zooey, pop).
       genre(eric, pop).
       genre(john, jazz).
       genre(jarvis, jazz).

  Our knowledge base has now to different kinds of facts, musicians and genres. Musicians associates a musician with an instrument, genres associate a musician with a genre. That's our world now.

- Find all musicians who play the guitar.

  Again, we start by loading the knowledge base in prolog:

        GNU Prolog 1.3.1
        By Daniel Diaz
        Copyright (C) 1999-2009 Daniel Diaz
        | ?- ['prolog/day-1/music'].
        compiling /Users/plagelao/development/languages/7languages7weeks/prolog/day-1/music.pl for byte code...
        /Users/plagelao/development/languages/7languages7weeks/prolog/day-1/music.pl compiled, 13 lines read - 983 bytes written, 17 ms

        yes

  Now, we ask prolog for all the musicians that play guitar:

        | ?- musician(Who, guitar).

        Who = jota ? a

        Who = m_ward

        Who = john

        yes

  As before, prolog gives as the correct data :) Let's do something a little bit more difficult, let's get all the musicians that sing pop songs. To do that, we need to add the following rule to our knowledge base:

        musician_instrument_and_genre(Musician, Instrument, Genre) :- musician(Musician, Instrument), genre(Musician, Genre).

  With this rule, prolog will be able to ask questions about musician and genre facts. Let's ask for the pop singers:

        | ?- musician_instrument_and_genre(Who, vocals, pop).

        Who = jota ? a

        Who = zooey

        Who = jarvis

        no

  Yes, it works! If we analyze what is happening, we have asked prolog Who is a pop vocalist. Who is the variable and vocals and pop are atoms, so musician_instrument_and_genre(Who, vocals, pop) is more or less the same as musician(Musician, vocals) AND genre(Musician, pop).

And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/exercises/prolog/day-1). I like how prolog works, let's see what we find out tomorrow.
