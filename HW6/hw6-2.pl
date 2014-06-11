:- use_module(library(clpr)).

% query ?- continuous_knapsack(Profit , O1 , O2 , O3 , O4 , O5 , O6).
continuous_knapsack(Profit , O1 , O2 , O3 , O4 , O5 , O6) :-
	{O1 >= 0 , O2 >= 0 , O3 >= 0 , O4 >= 0 , O5 >= 0 , O6 >= 0},
	{O1 =< 20 , O2 =< 50 , O3 =< 60 , O4 =< 15 , O5 =< 20 , O6 =< 30},
	{O1 + O2 + O3 + O4 + O5 + O6 =< 140},
	{ Profit = (O1/20) * 2 + (O2/50)*3 + (O3/60)*4 + (O4/15)*4 + (O5/20)*1 + (O6/30)*6 },
	maximize(Profit).