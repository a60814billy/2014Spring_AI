% N Queen - Version 2
% Homework#3 2. Program2
solution(N,Queens) :-
	gen(N,List),!,
	permutation(List, Queens),
	safe(Queens).
	  
safe([]).
safe([Queen|Others]) :- 
	safe(Others),
	noattack(Queen, Others, 1).
	  
noattack(_,[],_).
noattack(Y, [Y1|Ylist], Xdist) :-
	Y-Y1=\=Xdist, Y1-Y=\=Xdist,
	Dist1 is Xdist+1,
	noattack(Y, Ylist, Dist1). 

conc([] , List , List).
conc([A|Tail] , List , [A|P]) :- conc(Tail , List , P). 
insert(X , [] , [X]).
insert(X , OList , NList) :- conc(L1 , L3 , OList) , conc([X] , L3 , L4) , conc(L1 , L4 , NList).
%permutation([] , []).
%permutation([A|List] , P) :- permutation(List , P1) , insert(A , P1 , P).

gen(0 , []) :- !.
gen(N , List) :- Next is N - 1 , gen(Next , Nlist) , conc(Nlist , [N] , List).