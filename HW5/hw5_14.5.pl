
:-op(500, xfx, :).
:-op(600, xfx, --->).


a ---> or:[b/1, c/3].
b ---> and:[d/1, e/1].
c ---> and:[f/2, g/1].
e ---> or:[h/6].
f ---> or:[h/2, i/3].

goal(d).
goal(g).
goal(h).


h(_ , 0).


andor(Node, SolutionTree) :-
	expand(leaf(Node,0,0) , 9999, SolutionTree, yes).

% Procedure expand(Tree, Bound, NewTree, Solved)
% expands Tree with Bound Producing NewTree whose
% 'solution-status' is Solved

% Case 1:bound exceeded
expand(Tree, Bound, Tree, no) :-
	f(Tree, F) ,
	F > Bound , !.

%Case 2:goal encountered
expand(leaf(Node,F,C), _, solvedleaf(Node,F), yes) :-
	goal(Node) , !.

%Case 3:expanding a leaf
expand(leaf(Node,F,C), Bound, NewTree, Solved) :-
	expandnode(Node,C,Tree1) , !,
	expand(Tree1, Bound, NewTree, Solved)
	;
	Solved = never,!.

%Case 4:expanding a tree
expand(tree(Node,F,C,SubTrees), Bound, NewTree, Solved) :-
	Bound1 is Bound - C ,
	expandlist(SubTrees, Bound1, NewSubs, Solved1),
	continue(Solved1, Node, C, NewSubs, Bound, NewTree, Solved) .

% expandlist(Trees, Bound, NewTree, Solved)
% expands tree list Trees with Bound Producing
% NewTrees whose 'solved-status' is Solved

expandlist(Trees, Bound, NewTrees, Solved) :-
	selecttree(Trees, Tree, OtherTrees, Bound, Bound1),
	expand(Tree, Bound1, NewTree, Solved1),
	combine(OtherTrees, NewTree, Solved1, NewTrees,Solved).

% 'continue' decids how to continue after expanding a tree list

continue(yes, Node, C, SubTrees, _, solvedtree(Node, F, SubTrees), yes) :-
	backup(SubTrees, H), F is C + H , ! .

continue(never, _, _, _, _, _, never) :- !.

continue(no, Node, C, SubTrees, Bound, NewTree, Solved) :-
	backup(SubTrees, H), F is C + H , ! ,
	expand(tree(Node, F, C, SubTrees), Bound, NewTree, Solved).

% 'combine' combines results of expanding a tree and a tree list
combine( or:_, Tree , yes, Tree, yes) :- !.

combine( or:Trees, Tree, no, or:NewTrees ,no) :-
	insert(Tree, Trees, NewTrees) , ! .

combine( or:[], _, never, _, never) :- !.

combine(or:Trees, Tree, yes, and:[Tree|Trees], yes) :-
	allsolved(Trees) , !.

combine(and:Trees , Tree , yes , and:[Tree | Trees] , yes) :-
	allsolved(Trees) , !.

combine(and:_, _, never, _, never) :- !.

combine(and:Trees, Tree, YesNo, and:NewTrees, no) :-
	insert(Tree, Trees, NewTrees) , !.

% 'expandnode' makes a tree of a node and its successors

expandnode(Node, C, tree(Node, F, C, Op:SubTrees)) :-
	Node ---> Op:Successors,
	evaluate(Successors, SubTrees),
	backup(Op:SubTrees, H),
	F is C + H.

evaluate([] , []).

evaluate([Node/C | NodesCosts] , Trees) :-
	h(Node, H),
	F is C + H,
	evaluate(NodesCosts, Trees1),
	insert(leaf(Node, F, C), Trees1, Trees).

% 'allsolved' checks whether all trees in a tree list are solvedtree
allsolved([]).
allsolved([Tree|Trees]) :-
	solved(Tree),
	allsolved(Trees).

solved(solvedtree(_,_,_)).
solved(solvedleaf(_,_)).

f(Tree, F) :-
	arg( 2, Tree, F), !.

% insert( Tree, Trees, NewTrees) inserts Tree into
% tree list Trees producing NewTrees

insert(T , [] , [T]) :- ! .

insert(T, [T1 | Ts] , [T , T1 | Ts]) :-
	solved(T1) , !.

insert(T , [T1 | Ts] , [T1 | Ts1]) :-
	solved(T),
	insert(T , Ts, Ts1) , !.

insert(T , [T1 | Ts] , [T , T1 | Ts]) :-
	f(T,F) , f(T1,F1) , F =< F1 , !.

insert(T , [T1 | Ts] , [T1 | Ts1]) :-
	insert(T , Ts , Ts1).

% 'backup' finds the backed-up F-value of AND/OR tree list
backup( or:[Tree | _] , F) :-
	f(Tree,  F) , !.

backup( and:[] , 0) :- !.

backup( and:[Tree1 | Trees] , F) :-
	f(Tree1 , F1),
	backup( and:Trees , F2 ),
	F is F1 + F2 , ! .

backup( Tree , F) :-
	f(Tree, F).

% Relation selecttree(Trees, BestTree, OtherTrees, Bound, Bound1):
% OtherTrees is an AND/OR list Trees without its best member BestTree;
% Bound is expansion bound for Trees, Bound1 is expansion bound for BestTree

selecttree(Op:[Tree] , Tree, Op:[] , Bound, Bound) :- !.
selecttree(Op:[Tree | Trees] , Tree , Op:Trees , Bound , Bound1) :-
	backup(Op:Trees , F),
	(Op = or , ! , min(Bound , F , Bound1) ; Op = and, Bound1 is Bound - F ).

min(A , B , A) :- A < B , !.
min(A , B , B).

writenode(Node , H) :-
	write(Node),
	atom_length(Node , L),
	H is L.

show2(S) :-
	show(S , 0).


show(solvedtree(Node , H , Trees) , Offset) :-
	writenode(Node , H1) , write(' ---> '),
	NewOffset is Offset + 6 + H1 ,
	show(Trees , NewOffset).

show(solvedleaf(Node , H) , Offset) :-
	writenode(Node , H1) , nl .

show(and:Trees , Offset) :-
	showand(Trees , Offset).

showand([] , _).

showand([Tree | Trees] , Offset) :-
	show(Tree , Offset), nl , tab(Offset),
	showand(Trees , Offset).
