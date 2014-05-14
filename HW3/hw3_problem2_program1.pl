% N Queen - Version 1
% Homework#3 2. Program1 (1) , (2)

member(X , [Y|List]) :- X = Y ; member(X , List). 

solution(N , S) :- gen(N , List), solution2(List , S).

solution2(_, []).
solution2(List, [X/Y|Others]) :-
	solution2(List,Others),
	member(Y , List),
	noattack(X/Y, Others).

noattack(_ , []).
noattack(X/Y , [X1/Y1|Others]) :-
	Y=\=Y1 , Y1-Y=\=X1-X, Y1-Y=\=X-X1,
	noattack(X/Y , Others).
	
% get_template(N1 , N2 , List).
gen_template(N , N , [N/_]) :- !.
gen_template(N1 , N2 , [N1/_|L1] ) :- 
	NextN1 is N1 + 1,
	gen_template(NextN1 , N2 , L1).

conc( [] , List , List).
conc( [A|Tail] , List , [A|List1]) :- conc(Tail , List , List1).

gen(0 , []) :- !.
gen(N , List) :- Next is N - 1 , gen(Next , Nlist) , conc(Nlist , [N] , List).