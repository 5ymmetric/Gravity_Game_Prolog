:- use_module(library(clpfd)).

fewestRotationsSingle(Maze, Moves):-
    smallestMoveLengthFinder(Maze, MoveLength),
    minimumRotations(Maze, Moves, MoveLength).

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

applyGravityC(Maze, Final):-
    clockwise(Maze, R),
    updateMaze(R, 1, Final).

applyGravityCC(Maze, Final):-
    counterClockwise(Maze, R),
    updateMaze(R, 1, Final).

applyGravityOneEighty(Maze, Final):-
    oneEighty(Maze, R),
    updateMaze(R, 1, Final).

clockwise(Maze, RotatedMaze):-
    reverse(Maze, ReversedMaze),
    transpose(ReversedMaze, RotatedMaze).

counterClockwise(Maze, RotatedMaze):-
    transpose(Maze, TransposedMaze),
    reverse(TransposedMaze, RotatedMaze).

oneEighty(Maze, RotatedMaze):-
    clockwise(Maze, Once),
    clockwise(Once, RotatedMaze).

playerLocation(Maze, Player, (R, C)):-
    find2D(Player, Maze, (R, C)).

goalLocation(Maze, g, (R, C)):-
    find2D(g, Maze, (R, C)).

solved(Maze):-
    not(goalLocation(Maze, g, _)).

% dropn(Number,BeforeList,AfterList)
dropn(0,Before,Before).    
dropn(_,[],[]).    
dropn(N,[_|TB],TA):-
    length(_,N),    
    N > 0,    
    NM1 is N - 1,    
    dropn(NM1,TB,TA).

playerColumn(Maze, Player, H):-
    counterClockwise(Maze, RotatedMaze),
    playerLocation(RotatedMaze, Player, (R, _)),
    dropn(R, RotatedMaze, [H|_]).

updatePlayerColumn(Maze, Player, FinalColumn):-
    playerColumn(Maze, Player, H),
    playerLocation(Maze, 1, (R, _)),
    dropn(R, H, C1),
    dropn(1, C1, Column),
    playerMove(Column, Moves),
    FinalLocation is Moves + R,
    replacePlayer(Player, H, Result),
    replace(FinalLocation, Result, Player, FinalColumn).

updateMaze(Maze, Player, FinalMaze):-
    counterClockwise(Maze, RotatedMaze),
    playerLocation(RotatedMaze, Player, (R, _)),
    updatePlayerColumn(Maze, Player, FinalColumn),
    replace(R, RotatedMaze, FinalColumn, MazeF),
    clockwise(MazeF, FinalMaze).

replacePlayer(Player, List, Result):-
    append(Prefix,[Player|Suffix],List),
    append(Prefix, [-], Prefix1),
    append(Prefix1, Suffix, Result).

replace(Index, List, Element, Result):-
    nth0(Index, List, _, Temp),
    nth0(Index, Result, Element, Temp).

move(-).
move(g).

playerMove([x|_], 0).
playerMove([g|_], 1).
playerMove([H|T], Moves):-
    move(H),
    playerMove(T, MoveT),
    Moves is MoveT + 1.

minimumRotations(Maze, Paths, MaxLength):-
    between(1, MaxLength, MinPathsLength),
    length(Paths, MinPathsLength),
    paths(Maze, Paths),
    MaxLength is MinPathsLength.

smallestMoveLengthFinder(Maze, MoveLength):-
    between(1, 6, MinPathsLength),
    length(Paths, MinPathsLength),
    paths(Maze, Paths),
    MoveLength is MinPathsLength,
    !.

paths(Maze, []):-
    solved(Maze).

paths(Maze, [c|Paths]):-
    applyGravityC(Maze, RotatedMaze),
    paths(RotatedMaze, Paths).

paths(Maze, [cc|Paths]):-
    applyGravityCC(Maze, RotatedMaze),
    paths(RotatedMaze, Paths).

paths(Maze, [180|Paths]):-
    applyGravityOneEighty(Maze, RotatedMaze),
    paths(RotatedMaze, Paths).