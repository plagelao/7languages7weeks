---
layout: post
categories:
  - prolog
---
O_o Prolog? I'm a little bit confused... I think I understand how it works, and I'm starting to know when to apply it, but sometimes I just do not get how it can work.

Let's work together through the exercises to see if we reach the enlightenment.

- Reverse the elements of a list

  What does reverse a list of elements mean? Let's start with the easiest list. Reverse an empty list gives us an empty list:

        rev([], []).

  That was easy. Reverse a non empty list puts the first element in the last position and do the same with the rest of the list:

        rev([Head|Tail], Reversed) :- rev(Tail, ReversedTail), append(ReversedTail, [Head], Reversed).

  Ok! What are we saying here?:

        rev([Head|Tail], Reversed).

  This means that, to reverse a list, we want to separate the first element (Head) from the rest (Tail). Then, we want to reversed the rest of the list (Tail):

        rev(Tail, ReversedTail).

  And then, we want to append the first element of the original list (Head) at the end of the reversed tail:

        append(ReversedTail, [Head], Reversed).

  Does this work? Yes! Isn't it awesome? We are reversing a list just by telling prolog what reversing a list means :)

- Find the smallest element of a list

  Let's try to tell prolog what does it mean to find the smallest element of a list. Again, let's start with the easiest case. The smallest element of a list with one element is that element:

        smallest(Head, [Head]).

  When the list has more than one element, the smalles element is either the first element or the smallest element of the rest of the list:

        smallest(Element, [Head|Tail]) :- smallest(E, Tail), Head =< E, Element is Head.
        smallest(Element, [Head|Tail]) :- smallest(E, Tail), E < Head , Element is E.

  We need two rules, one if the first element is the smallest and one if it is not. And again, this works! I am starting to be really impressed with prolog. We are not saying HOW to solve the problems, we are defining the problems and prolog figures out how to resolve what we ask.

- Sort the elements of a list

  I have to say that this was not easy for me. I defined it wrong a lot of times... I did get the right solution trying to explain to my girlfriend what does sorting the elements of a list mean, which is really cool, I think. When using prolog we need to explain the problem instead of resolve it :D
  Ok, let's start. Again, sorting an empty list gives us an empty list:

        weird_sort([], []).

  Sorting a one element list gives us that list:

        weird_sort([Element], [Element]).

  Ok, let's start with the difficult part. Sorting a list where the first element is the smallest one means that we need to sort the rest of the list and append the first element of the original list to the beginning of the sorted list of the rest of the elements:

        weird_sort([Head|Tail], List) :- weird_sort(Tail, [SortedHead|SortedTail]), Head =< SortedHead, append([Head], [SortedHead|SortedTail], List).

  What!? Ok, lets go step by step. First we get the first element (Header) of the list and the rest (Tail). Then, we sort the tail of the original list and get the first element of the sorted tail (SortedHead). Then, we find out if the first element of the original list is smaller than the first element of the sorted list with the rest of the elements. If that is true, it means that the first element of the original list is the smallest element of the list. Then, we append the first element of the original list to the beginning of the sorted list with the rest of the elements.
  Mmmm, weird, isn't it? Ok, so now we can sort list that are already sorted... That's not very much. We are missing the last rule. If the first element is not the smallest one, we want to find the smallest one, sort all the other elements and append the smallest one to the beginning of the sorted list:

        weird_sort([Head|Tail], List) :- weird_sort(Tail, [SortedHead|SortedTail]), Head > SortedHead, weird_sort([Head|SortedTail], NewSortedTail), append([SortedHead], NewSortedTail, List).

  Like with the previous rule, we start by getting the first element and the rest of them. Then, we sort the list with the rest of the elements and get the first element of that list (the smallest one). Then, we find out if the first element of the original list is greater than the smallest of the rest of the elements. If it is greater, we sort a list formed by all the elements of the original list except the smallest one. And to finish, we append the smallest element of the original list to the beginning of the sorted list of all the other elements.

  Wow! That was not easy to "explain". Probably there is a better way to do it, but I have not found it.

I do not know if you have learned something with this, I have :) And I also did have a lot of fun trying to change my way of thinking when using prolog.

See you tomorrow with more prolog awesomeness!
