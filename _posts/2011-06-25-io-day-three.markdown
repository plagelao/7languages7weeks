---
layout: post
---
Io's last day has been a very fun day.

We learned how concurrency works in Io. It is very easy to start playing with it, but I have not done any thing else than the examples in the book, so I am not sure how it works when the thing gets complicated...
We also learned a lot about reflection, going a little bit further than [yesterday](http://plagelao.github.com/7languages7weeks/2011/06/23/io-day-two.html)

The author proposes three exercises to understand how to create DSLs with Io:

- Enhance the XML builder (an example from the book, you can [have a look at it here](https://github.com/plagelao/7languages7weeks/blob/exercises/io/day-3/xml_builder.io)) to add spaces to show the indentation structure.

  This is how I've changed the builder to indent the generated XML:

        Builder := Object clone

        Builder currentIndentation := 0

        Builder xmlNode := method(nodeName, children,
          openXmlNode := method(
            currentIndentation repeat(write(" "))
            writeln("<", nodeName, ">")
            currentIndentation = currentIndentation + 1
            )
          closeXmlNode := method(
            currentIndentation = currentIndentation - 1
            currentIndentation repeat(write(" "))
            writeln("</", nodeName, ">")
            )
          writeXmlText := method(
            (currentIndentation + 1) repeat(write(" "))
            writeln(content)
            )

          openXmlNode
          children foreach(
            arg,
            content := self doMessage(arg);
            if(content type == "Sequence", writeXmlText)
            )
          closeXmlNode
          )

        Builder forward := method(
          xmlNode(call message name, call message arguments)
          )

  The builder has knowledge of the current indentation and uses it every time it needs to write something. I add a level of indentation every time I open a node and remove a level of indentation when closing it. I also indent always the text for the node.
  What I like about this example is how easy it is to create a DSL with Io. All you need to do is understand how messages work.

- Create a list syntax that uses brackets

  We are going to add something to Io's syntax! To create a list in Io you can do:

        list(1,2,3)

  That instruction creates a list with the elements 1, 2 and 3. You can also create a list cloning the List prototype:

        List clone

  That creates an empty list.
  We are going to add another method to create lists:

        {1, 2, 3}

  How do we do that? I did it like this:

        curlyBrackets := method(
            l := List clone
            call message arguments foreach(arg,
              l append(doMessage(arg))
              )
            l
            )

  Every time the Io parser finds a pair of curly brackets, it sends the message curlyBrackets. We are changing the curlyBrackets slot so it does what we want to do. The problem is that, if someone was using curlyBrackets before, our change is going to break its code... We have to be careful.

- Enhance the XML builder to handle attributes.

  This exercise goal is to make our builder transform this:

        library({"owner":"plagelao"},
            book({"author":"Tate"},
              "7 languages in 7 weeks"),
            book({"author":"Crockford"},
              "Javascript: The good parts")
            )

  into this:

        <library owner=plagelao>
          <book author=Tate>
            7 languages in 7 weeks
          </book>
          <book author=Crockford>
            Javascript: The good parts
          </book>
        </library>

  My builder after the changes looks like this:

        doFile("./io/day-3/json_hash.io")

        asXmlAttributes := method(
            call target asList map(a, a at(0) asMutable appendSeq("=") appendSeq(a at(1))) join(", ")
            )

        Builder := Object clone

        Builder currentIndentation := 0

        Builder xmlNode := method(nodeName, attributes, children,
            openXmlNode := method(
              currentIndentation repeat(write(" "))
              writeln("<", nodeName, " ", attributes asXmlAttributes, ">")
              currentIndentation = currentIndentation + 1
              )
            closeXmlNode := method(
              currentIndentation = currentIndentation - 1
              currentIndentation repeat(write(" "))
              writeln("</", nodeName, ">")
              )
            writeXmlText := method(
              (currentIndentation + 1) repeat(write(" "))
              writeln(content)
              )

            openXmlNode
            children foreach(
              arg,
              content := self doMessage(arg);
              if(content type == "Sequence", writeXmlText)
              )
            closeXmlNode
            )

        Builder forward := method(
            args := call message arguments
            if(doMessage(args at(0)) type == "Map",
              xmlNode(call message name, doMessage(args removeAt(0)), args),
              xmlNode(call message name, Map clone, args))
            )

  The first thing I do is to "require" the code that converts a JSON structure into a hash (It is an example of the book, you can [have a look at the code here](https://github.com/plagelao/7languages7weeks/blob/exercises/io/day-3/json_hash.io)). I do that with doFile, as [Susan Potter](http://twitter.com/SusanPotter) [explains here](http://mbbx6spp.github.com/7languages7weeks/2011/06/20/io-requires.html?utm_source=twitterfeed&utm_medium=twitter).
  After that, I change the forward message to see if there is any attribute in the XML. I do that by comparing the first argument type with a Map (the attributes are always a map). Then, I write the attributes for the node, if there are any.

That's all for today, see you tomorrow with my Io final thoughts.
