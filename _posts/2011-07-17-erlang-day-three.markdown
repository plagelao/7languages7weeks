---
layout: post
categories:
  - erlang
---
ERLANG IS AWESOME!

Today we have learned about concurrency and it is really nice and powerful. I am eager to know more :) [Susan Potter](https://twitter.com/susanpotter/) sent me [this link](http://learnyousomeerlang.com/) yesterday. I have not read it yet, but it looks great (Thanks Susan).

Let's have a look at today exercises:

- Monitor the translate_service and restart it should it die.

  This is the code for the translator:

        -module(translator).
        -export([loop/0]).

        loop() ->
          receive
            "casa" ->
              io:format("house~n"),
              loop();

            "blanca" ->
              io:format( "white~n"),
              loop();

            _ ->
              io:format("I don't understand.~n"),
              loop()
          end.

  It is a simple service that waits for a message in a loop (a recursive loop) and process the message once it get it (printing out a translation or a "I don't know" sentence).
  I have create a monitor for the translation service called frankestein (It has the power of creating life):

        -module(frankestein).
        -export([experiment/0]).

        experiment() ->
          process_flag(trap_exit, true),
          receive
            new ->
              io:format("It's alive!~n"),
              register(translator, spawn_link(fun translator:loop/0)),
              experiment();
            {'EXIT', From, Reason} ->
              io:format("The translator ~p died: ~p ~n", [From, Reason]),
              io:format("Let's create life~n"),
              self() ! new,
              experiment()
          end.

  This service creates a new translator every time some one tells it to do it (the new action) and gets a notification when the translation service stop working. We do that with the {'EXIT', From, Reason} option. In case you did not notice, when frankestein creates the translator it uses spawn_link, which links frankestein to the translation service (for example, if the translator is killed, before stopping it sends a message to its link, frankestein, in the form of {'Exit', From, Reason}). When frankestein notice that the translator is dead, it sends the new message to itself (self() ! new), which creates a new translator.
  Let's see this working. First, we compile frankestein and the translator:

        2> c(frankestein).
        {ok,frankestein}
        3> c(translator).
        {ok,translator}

  Then, we create a Doctor Frankestein:

        4> Doctor = spawn(fun frankestein:experiment/0).
        <0.49.0>

  Now, we send the message new to the doctor so it creates a new translator:

        5> Doctor ! new.
        It's alive!
        new

  See that "It's alive" there? That means that we have create a translator. Let's translate some words:

        6> translator ! "casa".
        "casa"
        house
        7> translator ! "azul".
        I don't understand.
        "azul"

  Ok, now we are going to kill the translator and see if Frankestein is able to create life from death:

        8> exit(whereis(translator), "Not a very good translator").
        true
        The translator <0.51.0> died: "Not a very good translator"
        Let's create life
        It's alive!

  Wow! So it seems that Frankestein did it! Let's try to use the translator:

        9> translator ! "casa".
        house
        "casa"

  Yes, Frankestein succeeded! Just awesome.

- Make the Doctor process (frankestein in this case) restart itself if it should die.

  What!? Does this mean that a process in Erlang can restarts itself? I will believe it when I see it. This is the code for the solution:

        -module(zombie).
        -export([experiment/0]).

        experiment() ->
          process_flag(trap_exit, true),
          receive
            new ->
              io:format("The translator is alive!~n"),
              register(translator, spawn_link(fun translator:loop/0)),
              experiment();

            {'EXIT', From, Reason} ->
              case Reason of
                translator ->
                  io:format("The process ~p killed the translator ~n", [From]),
                  io:format("Let's create life~n"),
                  self() ! new,
                  experiment();
                doctor ->
                  io:format("The process ~p killed the doctor ~n", [From]),
                  io:format("The doctor is a zombie now!~n"),
                  exit(whereis(translator), translator),
                  Zombie = spawn(fun zombie:experiment/0),
                  Zombie ! new
              end
          end.

  Everything is as in the previous exercise except for the {'EXIT', From, Reason} messages. Now we have a case to know which process is stopping. If the process stopping is the translator we restart it, if the process stopping is the doctor, we start a new doctor (A zombie one), create a new translator associated to that new doctor and stop the translator associated to the current doctor.
  Let's see if it works:

        1> c(zombie).
        {ok,zombie}
        2> c(translator).
        {ok,translator}
        3> Doctor = spawn(fun zombie:experiment/0).
        <0.43.0>
        4> Doctor ! new.
        The translator is alive!
        new
        5> translator ! "casa".
        house
        "casa"

  This is the same as before. We start a doctor and translator, and we translate some words.

        6> exit(Doctor, doctor).
        The process <0.31.0> killed the doctor 
        true
        The doctor is a zombie now!
        The translator is alive!

  Now we stop the doctor. If you read the messages, it works! Let's see if we can still translate words:

        7> translator ! "casa".
        house
        "casa"

  Yes! Let's stop the translator and see if the zombie doctor knows how to restart it:

        8> exit(whereis(translator), translator).
        The process <0.45.0> killed the translator 
        true
        Let's create life
        The translator is alive!

  Well, it seems it does. Let's see if we can use the translator:

        10> translator ! "casa".
        house
        "casa"

  And yes! We can. Awesome! A process can restart itself in Erlang :) I am cheating a little bit here. I really do not know what process is stopping so I use the Reason as a discriminator. I am sure there is a better way to know which process is stopping.

- Make a monitor for the Doctor monitor. If either monitor dies, restart it.

  This exercise is more or less the same as the other ones and I am really tired, so I leave it to you :D
