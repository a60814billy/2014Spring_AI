% 100590309 HW1
% 2014/2/28
% 1.Define the facts see(Block, X, Y). Block is observed by camera at coordinates X and Y. 
see(b, 2, 2).
see(c, 6, 6).
see(d, 5, 2).
see(f, 4, 2).
see(k, 6, 1).

% 2. Define the facts on(Block, Object). Block is standing on Object.
on(a, table).
on(b, h).
on(c, i).
on(d, table).
on(e, table).
on(f, g).
on(g, table).
on(h, a).
on(i, e).
on(j, table).
on(k, j). 

% 3.Define the relation under(Block1, Block2) using on and under relation. Block1 is under the Block2.

under(Block1 , Block2) :- on(Block2 , Block1).
under(Block1 , Block2) :- on(Block2 , BlockX), under(Block1, BlockX).

% 4.Define the rule x(Block, X).
x(Block, X) :- see(Block, X, _).
x(Block, X) :- on(BlockX, Block) , x(BlockX, X), Block \== table.

% 5.Define the rule y(Block, Y).
y(Block, Y) :- see(Block, _, Y).
y(Block, Y) :- on(BlockX, Block) , y(BlockX, Y), Block \== table.

% 6.Define the rule xyz(Block, X, Y, Z).
z(Block, Z) :- on(Block,table),Z is 0.
z(Block, Z) :- on(Block,BlockX), z(BlockX,ZX) , Z is ZX +1.
xyz(Block, X , Y, Z) :- x(Block, X) ,y(Block, Y) ,z(Block, Z).

% 7. Formulate in Prolog the following questions: 
% 7.1 x(Block, 6).
% 7.2 y(Block, 2). 