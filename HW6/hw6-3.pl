:- use_module(library(clpfd)).

% query ?- continuous_knapsack(Profit , O1 , O2 , O3 , O4 , O5 , O6).
continuous_knapsack(Profit , O1 , O2 , O3 , O4 , O5 , O6) :-
	Vars = [O1 , O2 , O3 , O4 , O5 , O6],
	Vars ins 0..1,
	O1 * 20 + O2 * 50 + O3 * 60 + O4 * 15 + O5 * 20 + O6 * 30 #=< 140,
	O1 * 2 + O2 * 3 + O3 * 4 + O4 * 4 + O5 * 1 + O6 * 6 #= Profit,
	labeling([max(Profit)] , [Profit,O1,O2,O3,O4,O5,O6]) , !.