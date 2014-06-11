:- use_module(library(clpq)).
        
coin_change(Money ,N1 , N8 , N11) :-
	Vars = [N1 , N8 , N11],
	Vars ins 0..Money,
	N1 + N8 * 8 + N11 * 11 #= Money,
	labeling([min(N1) , min(N8) , min(N11)] , [N1,N8,N11]) , !.