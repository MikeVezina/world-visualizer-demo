location(X, Y)[possibly]
  :-  locPercept(location(X, Y), _).

percept(Direction, Object)[necessary] :- location(X, Y) & locPercept(location(X, Y), Perceptions) & .member(percept(Direction, Object), Perceptions).
//adjacent(MoveDir, Prev)[necessary] :- location(X, Y) & locAdjacent(location(X, Y), Adj) & .member(adjacent(MoveDir, Prev), Adj).
//direction(Dir)[necessary] :- location(X, Y) & locDirToGoal(location(X,Y), Dirs) & .member(Dir, Dirs).
//goalRelative(Gx, Gy)[necessary] :- location(X, Y) & locGoalRel(location(X,Y), location(Gx, Gy)).



/** These are the beliefs generated for the map that are added automatically to the BB **/
// Map Location Mappings
locPercept(location(0,0),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(0,1),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(0,2),[percept(up,none),percept(down,none),percept(right,obstacle),percept(left,none)]).
locPercept(location(0,3),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(0,4),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(1,0),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(1,1),[percept(up,none),percept(down,obstacle),percept(right,none),percept(left,none)]).
locPercept(location(1,3),[percept(up,obstacle),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(1,4),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(2,0),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(2,1),[percept(up,none),percept(down,obstacle),percept(right,none),percept(left,none)]).
locPercept(location(2,3),[percept(up,obstacle),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(2,4),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(3,0),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(3,1),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(3,2),[percept(up,none),percept(down,none),percept(right,none),percept(left,obstacle)]).
locPercept(location(3,3),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(3,4),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(4,0),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(4,1),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(4,2),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(4,3),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).
locPercept(location(4,4),[percept(up,none),percept(down,none),percept(right,none),percept(left,none)]).

// Adjacent Location Mappings
locAdjacent(location(0,0),[adjacent(up,location(0,1)),adjacent(left,location(1,0))]).
locAdjacent(location(0,1),[adjacent(down,location(0,0)),adjacent(up,location(0,2)),adjacent(left,location(1,1))]).
locAdjacent(location(0,2),[adjacent(down,location(0,1)),adjacent(up,location(0,3))]).
locAdjacent(location(0,3),[adjacent(down,location(0,2)),adjacent(up,location(0,4)),adjacent(left,location(1,3))]).
locAdjacent(location(0,4),[adjacent(down,location(0,3)),adjacent(left,location(1,4))]).
locAdjacent(location(1,0),[adjacent(right,location(0,0)),adjacent(up,location(1,1)),adjacent(left,location(2,0))]).
locAdjacent(location(1,1),[adjacent(right,location(0,1)),adjacent(down,location(1,0)),adjacent(left,location(2,1))]).
locAdjacent(location(1,3),[adjacent(right,location(0,3)),adjacent(up,location(1,4)),adjacent(left,location(2,3))]).
locAdjacent(location(1,4),[adjacent(right,location(0,4)),adjacent(down,location(1,3)),adjacent(left,location(2,4))]).
locAdjacent(location(2,0),[adjacent(up,location(2,1)),adjacent(left,location(3,0)),adjacent(right,location(1,0))]).
locAdjacent(location(2,1),[adjacent(down,location(2,0)),adjacent(left,location(3,1)),adjacent(right,location(1,1))]).
locAdjacent(location(2,3),[adjacent(up,location(2,4)),adjacent(left,location(3,3)),adjacent(right,location(1,3))]).
locAdjacent(location(2,4),[adjacent(down,location(2,3)),adjacent(left,location(3,4)),adjacent(right,location(1,4))]).
locAdjacent(location(3,0),[adjacent(right,location(2,0)),adjacent(up,location(3,1)),adjacent(left,location(4,0))]).
locAdjacent(location(3,1),[adjacent(right,location(2,1)),adjacent(up,location(3,2)),adjacent(down,location(3,0)),adjacent(left,location(4,1))]).
locAdjacent(location(3,2),[adjacent(up,location(3,3)),adjacent(down,location(3,1)),adjacent(left,location(4,2))]).
locAdjacent(location(3,3),[adjacent(right,location(2,3)),adjacent(down,location(3,2)),adjacent(up,location(3,4)),adjacent(left,location(4,3))]).
locAdjacent(location(3,4),[adjacent(right,location(2,4)),adjacent(down,location(3,3)),adjacent(left,location(4,4))]).
locAdjacent(location(4,0),[adjacent(up,location(4,1)),adjacent(right,location(3,0))]).
locAdjacent(location(4,1),[adjacent(down,location(4,0)),adjacent(up,location(4,2)),adjacent(right,location(3,1))]).
locAdjacent(location(4,2),[adjacent(up,location(4,3)),adjacent(down,location(4,1)),adjacent(right,location(3,2))]).
locAdjacent(location(4,3),[adjacent(up,location(4,4)),adjacent(down,location(4,2)),adjacent(right,location(3,3))]).
locAdjacent(location(4,4),[adjacent(down,location(4,3)),adjacent(right,location(3,4))]).

// Location Goal Rel. Mappings
locGoalRel(location(0,0),location(0,2)).
locGoalRel(location(0,1),location(0,1)).
locGoalRel(location(0,2),location(0,0)).
locGoalRel(location(0,3),location(0,-1)).
locGoalRel(location(0,4),location(0,-2)).
locGoalRel(location(1,0),location(-1,2)).
locGoalRel(location(1,1),location(-1,1)).
locGoalRel(location(1,3),location(-1,-1)).
locGoalRel(location(1,4),location(-1,-2)).
locGoalRel(location(2,0),location(2,0)).
locGoalRel(location(2,1),location(-2,1)).
locGoalRel(location(2,3),location(-2,-1)).
locGoalRel(location(2,4),location(-2,-2)).
locGoalRel(location(3,0),location(1,0)).
locGoalRel(location(3,1),location(1,-1)).
locGoalRel(location(3,2),location(-3,0)).
locGoalRel(location(3,3),location(-3,-1)).
locGoalRel(location(3,4),location(-3,-2)).
locGoalRel(location(4,0),location(0,0)).
locGoalRel(location(4,1),location(0,-1)).
locGoalRel(location(4,2),location(0,-2)).
locGoalRel(location(4,3),location(0,-3)).
locGoalRel(location(4,4),location(0,-4)).

// Location Direction Mappings
locDirToGoal(location(0,0),[down]).
locDirToGoal(location(0,1),[down]).
locDirToGoal(location(0,2),[none]).
locDirToGoal(location(0,3),[up]).
locDirToGoal(location(0,4),[up]).
locDirToGoal(location(1,0),[left,right,down]).
locDirToGoal(location(1,1),[left]).
locDirToGoal(location(1,3),[left]).
locDirToGoal(location(1,4),[left,up]).
locDirToGoal(location(2,0),[right]).
locDirToGoal(location(2,1),[left,right,up]).
locDirToGoal(location(2,3),[left]).
locDirToGoal(location(2,4),[left,up]).
locDirToGoal(location(3,0),[right]).
locDirToGoal(location(3,1),[right,up]).
locDirToGoal(location(3,2),[right,up]).
locDirToGoal(location(3,3),[left,right,up]).
locDirToGoal(location(3,4),[left,right,up]).
locDirToGoal(location(4,0),[none]).
locDirToGoal(location(4,1),[up]).
locDirToGoal(location(4,2),[up]).
locDirToGoal(location(4,3),[up]).
locDirToGoal(location(4,4),[up]).

