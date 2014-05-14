% Homework#3 1.

odd_even( [] , [] , []).
odd_even( [X|L1] , [X|L2] , L3 ) :- odd_even(L1 , L2 , L3) ,1 =:= X mod 2.
odd_even( [X|L1] , L2 , [X|L3] ) :- odd_even(L1 , L2 , L3) ,0 =:= X mod 2.