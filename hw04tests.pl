printPaths([]).
printPaths([Path|Paths]):-
    writeln(Path),
    printPaths(Paths).

loadHelpers:-
    ['helpers'],
    ['csce322hw04pt01'],
    ['csce322hw04pt02'],
    ['csce322hw04pt03'],
    ['csce322hw04pt04'].
    
part01:-
    readGravityMazeFile('part01test01.g',Rotations,Maze),
    writeln(rotations),
    writeln(Rotations),
    writeln(maze),
    printMazeGame(Maze),
    rotationsAndPlayers(Rotations,Maze).

part02:-
    readGravityMazeFile('part02test01.g',_,Maze),
    writeln(maze),
    printMazeGame(Maze),
    setof(Moves,fewestRotationsSingle(Maze,Moves),Paths),
    writeln(paths),
    printPaths(Paths).

part03:-
    readGravityMazeFile('part03test03.g',_,Maze),
    writeln(maze),
    printMazeGame(Maze),
    notStacked(Maze).
    
part04:-
    readGravityMazeFile('part04test02.g',_,Maze),
    writeln(maze),
    printMazeGame(Maze),
    setof(Moves,fewestRotationsMultiple(Maze,Moves),Paths),
    writeln(paths),
    printPaths(Paths).
    
