---
layout: post
categories:
  - clojure
---
Clojure week is over and I still do not know what to think about it. I like some of it parts and I dislike others, so probably I need to use it a lot more to get a better opinion.

Anyway, let's talk about the third Clojure day. This day is all about concurrency. We learn about references, atoms and agents and start to understand how to use them. The exercises for this day are a good example of how those works:

- User refs to create a vector of accounts in memory. Create debit and credit functions to change the balance of an account

  Yesterday I said that I did not like protocols and types, so Stuart Halloway point me to [this link](https://www.ibm.com/developerworks/java/library/j-clojure-protocols/) to understand why we need them. It is a very good link and I recommend you to read it. Trying to understand those concepts a little bit better, I use protocols and types (apart from references) to solve this exercise:


        (defprotocol Account
          (debit [this quantity])
          (credit [this quantity]))

        (defrecord BankAccount [balance]
          Account
          (debit [this quantity]
            (BankAccount. (- balance quantity)))
          (credit [this quantity]
            (BankAccount. (+ balance quantity))))

        (defn account [balance] (BankAccount. balance))
        (def accounts (ref [(account 50)]))
        (defn add-money [amount]
          (dosync (ref-set accounts (map (fn [a] (credit a amount)) @accounts))),
          @accounts)
        (defn subtract-money [amount]
          (dosync (ref-set accounts (map (fn [a] (debit a amount)) @accounts))),
          @accounts)

  I define the protocol Account and the type BankAccount, so I can use the functions debit and credit on BankAccount structures. Then, I declare the reference accounts, a vector of accounts. Then, I have a add-money and a subtract-money functions to change the reference accounts. As you can see, there is a lot of syntax involve in changing a reference value.

- Solve the [sleeping barber problem](http://en.wikipedia.org/wiki/Sleeping_barber_problem)

  This was a very difficult exercise for me, and I do not really know if it is bug-free... The important thing, though, is that I understand a little bit better how agents work in Clojure.

  So, we want to count how many haircuts can the barber give, so let's create an agent with the current count of given haircuts and a function to add a haircut to the counter:

        (def haircuts (agent 0))

        (defn add-haircut [h]
          (+ 1 h))

  To add a new haircut we need to send the message to the agent:

        (send haircuts add-haircut)

  We also know that there can only be a maximum of 4 clients in the barber shop, one on the barber chair and 3 waiting, so we create an agent with the count of people in the barber shop and a function to decide where to put a new client:

        (def customers-in-shop (agent 0))

        (defn customer-in-shop [c]
          (cond (= c 0) (customer-has-a-haircut c)
                (< c 3) (customer-waits-for-a-haircut c)
                (= c 3) (customer-leaves-the-shop-without-a-haircut c)))

  If there are none, the client goes to the barber chair. If the barber chair is not free, the client waits. If there are three clients already waiting, the new client leaves. Let's have a look at the functions. First the easy one, the client leaves without a haircut:

        (defn customer-leaves-the-shop-without-a-haircut [c]
          c)

  It does not do anything :) Let's see what happens when the client waits:

        (defn customer-waits-for-a-haircut [c]
          (+ c 1))

  It adds one to the clients count. And now the one with the haircut:

        (defn customer-has-a-haircut [c]
          (send customers-in-shop customer-leaves-the-shop-with-a-haircut)
          (+ c 1))

  It sends a message to the waiting clients agent so the barber give a haircut to one of them and adds a client to the counter. What does customer-leaves-the-shop-with-a-haircut?:

        (defn customer-leaves-the-shop-with-a-haircut [c]
          (Thread/sleep 20)
          (send haircuts add-haircut)
          (if (> c 1)
            (send customers-in-shop customer-leaves-the-shop-with-a-haircut))
          (- c 1))

  The barber spend 20 milliseconds with each haircut, then sends the add-haircut to the haircuts agent. After that, if there are clients waiting, it sends a message to the waiting clients agent so the barber give a haircut to one of them. Then, it removes the current client form the clients count.

  The las thing we need is a loop to get new clients to the barber shop every 10-30 milliseconds:

        (def client (agent 0))

        (defn arrive [c]
          (Thread/sleep (+ 10 (rand-int 20)))
          (send customers-in-shop customer-in-shop)
          (send client arrive)
          c)

  To count how many haircuts gives the barber in n seconds we use this function:

        (defn how-many-customers-with-a-new-haircut-in [seconds]
          (send customers-in-shop #(* % 0))
          (send client arrive)
          (Thread/sleep (* 1000 seconds))
          @haircuts)

  In case you are wondering, the barber gives between 450 and 470 haircuts :)

  And that's all for today. As always, you can [check out my examples in my github repository for 7 languages in 7 weeks](https://github.com/plagelao/7languages7weeks/tree/master/clojure/day-3).

  See you next week!
