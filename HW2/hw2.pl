transfer(getbanana, state(window, unlock, A , hasnot) , state(window , unlock , A , has)).
transfer(unlock, state(window, lock, has, A) , state(window, unlock, has , A)).
transfer(pickkey, state(middle, A, hasnot, B) , state(middle, A , has, B)).
transfer(walk(L1,L2), state(L1,A,B,C) , state(L2,A,B,C)).
canget(state(_,_,_,has)).
canget(State1) :- transfer( _,  State1, State2) ,  canget(State2).
