:- consult('4-1').
:- begin_tests(hw4).

test(gen1) :- gen(0, []).
test(gen2) :- gen(1, [1]).
test(gen3) :- gen(3, [1,2,3]).
test(gen4) :- gen(5, [1,2,3,4,5]).

test(fetch1) :- fetch([1,2,3] , 1),!.
test(fetch2) :- fetch([1,2,3] , 2),!.
test(fetch3) :- fetch([1,2,3] , 3),!.

test(s1) :- s(board([1/1,1/2,2/1] , 3 , []) , board([] , 3 , [1/1]) , 1) , !.
test(s2) :- s(board([1/3,1/2,2/3] , 3 , []) , board([] , 3 , [1/3]) , 1) , !.
test(s3) :- s(board([3/3,3/2,2/3] , 3 , []) , board([] , 3 , [3/3]) , 1) , !.
test(s4) :- s(board([3/1,3/2,2/1] , 3 , []) , board([] , 3 , [3/1]) , 1) , !.
test(s5) :- s(board([1/1,1/2,1/3,2/2] , 3 ,[]) , board([] , 3 , [1/2]) , 1),!.
test(s6) :- s(board([] , 3 , []) , board([2/1, 2/3, 1/2, 3/2, 2/2] , 3, [2/2]), 6), !.


test(h1) :- h(board([] , 3 , []) , 0).
test(h2) :- h(board([1/1,1/2] , 3 , []) , 2).
test(h3) :- h(board([1/1,1/2,2/2,2/3,3/3] , 3 , []) , 5).

test(conc1) :- conc([] , [] , []).
test(conc2) :- conc([] , [1,2] , [1,2]).
test(conc3) :- conc([1,2] , [] , [1,2]).
test(conc4) :- conc([1,2] , [3,4] , [1,2,3,4]).

:- end_tests(hw4).