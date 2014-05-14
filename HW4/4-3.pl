:- consult(bestfirst).

% Data Struct:
% board( list of light on location X/Y , board's size (only support square board) , list of solution (default use empty list) )

% board example 
%    -------
% 1 | 1 O 1 |
% 2 | O O O |
% 3 | 1 O 1 |
% Y  -------
% / X 1 2 3
%

% all board's goal is list of light on is empty 
goal(board([] , _ , _)).

start(board([1/1, 1/4, 2/2, 2/3, 2/4, 3/2, 3/5, 4/1, 4/3, 5/1, 5/3, 5/4] , 5, [])).

conc([] , S , S).
conc([A|T] , S ,[A|S1] ) :-
	conc(T , S , S1).

% generation list , 1 to N
% gen(N , Result).
gen(0 , []) :- !.
gen(Size , S) :-
	NS is Size - 1,
	gen(NS , L),
	conc(L , [Size] , S).

fetch( [A|_] , A).
fetch( [_|L] , B) :- fetch(L , B).

% State transfer function
% Generation a list 1 to size of board , 
% fetch 1 X and 1 Y location to push.
s( board(S1 , Size , L)  ,  board( S2 , Size , [X1/Y1 | L] ) , W ) :- 
	gen(Size , X) , gen(Size , Y) , fetch(Y , Y1), fetch(X , X1) , 
	not(member(X1/Y1 , L)),
	pushButton(X1/Y1 , board(S1 , Size , _) , board(S2 , Size , _) , W). 

% H function
% when all is off , H is 0
% otherwise H is count of light on
h( board(S1 , _ , _) , H) :-
	length(S1 , H1) , 
	%calcweigth(S1 , H2 , Size)
	%calc(S1 , Size , H3),
	H is H1 .

pushButton(X/Y , board(L1 , Size , _) , board(L2 , Size , _) , W ) :-
	X1 is X + 1 , X2 is X - 1 , Y1 is Y + 1 , Y2 is Y - 1 ,
	turnOnOff(X/Y , L1 , L3 , Size,W1), turnOnOff(X1/Y , L3 , L4, Size,W2),
	turnOnOff(X2/Y , L4, L5, Size,W3) , turnOnOff(X/Y1 , L5 , L6, Size,W4) , turnOnOff(X/Y2 , L6 , L2, Size,W5),
	W is W1 + W2 + W3 + W4 + W5 +1.

turnOnOff(X/Y , L , L2 , Size,W) :-
	X > Size , ! , L2 = L ,W is 0 ;
	X < 1 , ! , L2 = L ,W is 0;
	Y > Size , ! , L2 = L ,W is 0;
	Y < 1 , ! , L2 = L ,W is 0;
	member(X/Y , L) , delete(L , X/Y , L2) , W is 0  ,!
	;
	L2 = [X/Y|L] , W is 1.

showboard( [] ).
showboard( [ board(S1 , Size , []) | T ] ) :-
	showboard(T),
	Total is Size * Size,
	genwhiteboard(Total , B),
	addtoboard(S1 , Size , B , B1),
	showb(B1 , Size , 0),
	format("---------------------"),nl.
showboard( [ board(S1 , Size , [X/Y|_]) | T ] ) :-
	showboard(T),
	Total is Size * Size,
	genwhiteboard(Total , B),
	addtoboard(S1 , Size , B , B1),
	format("push ") ,  write(X/Y) , nl,
	showb(B1 , Size , 0),
	format("---------------------"),  nl .
	

addtoboard( [] , _ ,  L , L).
addtoboard( [X/Y|T] , Size ,  L , L2 ) :-
	addtoboard(T , Size , L , L1),
	Loc is ((Y-1) * Size + X),
	lighton(Loc , L1 , L2).

lighton(1 , [_|T] , [1|T]) :- !.
lighton(S , [A|T] , [A|T1]) :- 
	S1 is S - 1 , 
	lighton(S1 , T , T1).

genwhiteboard( 0 , []) :- !.

genwhiteboard(Size , [0 | L]) :-
	S is Size - 1 , 
	genwhiteboard(S , L) , !.

% showb( [0,0,0,0,0...] , 5 , 0 ).
showb([] , _ , _) :- !.
showb([A|T] , Size , Now ) :-
	write(A) , format(" "),
	N is Now + 1,
	N1 is mod(N , Size),
	( (N1 = 0 , nl) ; true ),
	showb(T , Size , N) , !.
	
main :- start(S) , bestfirst(S , S1) , showboard(S1).
:- initialization(main).