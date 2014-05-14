fib(1 , 1) :- !.
fib(2 , 1) :- !.
fib(N, Value) :-
	N1 is N-1,
	N2 is N-2,
	fib(N1 , Value1),
	fib(N2 , Value2),
	Value is Value1 + Value2.
