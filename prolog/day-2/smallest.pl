smallest(Head, [Head]).
smallest(Element, [Head|Tail]) :- smallest(E, Tail), Head =< E, Element is Head.
smallest(Element, [Head|Tail]) :- smallest(E, Tail), E < Head , Element is E.
