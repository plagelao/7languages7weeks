my_sort([], []).
my_sort([E], [E]).
my_sort([Head|Tail], List) :- my_sort(Tail, [SortedHead|SortedTail]), append([Head], [SortedHead|SortedTail], List), Head =< SortedHead.
my_sort([Head|Tail], List) :- my_sort(Tail, [SortedHead|SortedTail]), Head > SortedHead, my_sort([Head|SortedTail], NewSortedTail), append([SortedHead], NewSortedTail, List).
