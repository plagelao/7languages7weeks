new_reverse([],[]).
new_reverse([Head|Tail],List) :- new_reverse(Tail, ReversedTail), append(ReversedTail,[Head],List).
