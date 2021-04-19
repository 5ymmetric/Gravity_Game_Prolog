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
    setof(Player, 
    (numlist(1, 4, PossiblePlayerList),
    member(Player, PossiblePlayerList),
    playerFound(Maze, Player)), PlayerList),
    length(PlayerList, Count).

playerFound(Maze, Player):-
    find2D(Player, Maze, Where).
