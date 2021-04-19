notStacked(Maze):-
    stackedPlayerCounter(Maze, Count),
    0 =:= Count.

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

stackedPlayerCounter(Maze, Count):-
    findall(X-Y, (numlist(1,4,NL),
    member(X, NL),
    member(Y, NL),
    X =\= Y,
    playerRow(Maze, X, Y)), L),
    length(L, Count).

playerRow(Maze, X, Y):-
    find2D(X, Maze, (R, C)),
    find2D(Y, Maze, (R1, C1)),
    1 is abs(R - R1),
    0 is abs(C - C1).
