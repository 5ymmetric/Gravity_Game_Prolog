rotationsAndPlayers(Rotations,Maze):-
    length(Rotations, NumberOfMoves),
    playerCounter(Maze, Count),
    0 is mod(Count, 2),
    0 is mod(NumberOfMoves ,2).

rotationsAndPlayers(Rotations,Maze):-
    length(Rotations, NumberOfMoves),
    playerCounter(Maze, Count),
    1 is mod(Count, 2),
    1 is mod(NumberOfMoves ,2).

% find2D(What,ListOfLists,Where)
find2D(What,[Row|_],(0,Column)):-    
    find(What,Row,Column).    
    find2D(What,[_|Rows],(R,C)):-    
    find2D(What,Rows,(RowsR,C)),    
    R is RowsR + 1.

% find(What,List,Where)    
    find(What,[What|_],0).
    find(What,[_|T],Where):-
    find(What,T,WhereT),    
    Where is WhereT + 1.

playerCounter(Maze, Count):-
    setof(X, (numlist(1,4,NL),
    member(X, NL),
    playerFound(Maze, X)), L),
    length(L, Count).

playerFound(Maze, X):-
    find2D(X, Maze, Where).
