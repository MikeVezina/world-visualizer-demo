/* Generated Data */
all_locations(1,1).
all_locations(1,2).
all_locations(1,3).

all_locations(2,1).
all_locations(2,2).
all_locations(2,3).

all_locations(3,1).
all_locations(3,2).
all_locations(3,3).


// Each poss_grid has a unique ID (1-4)

poss_grid(1,
    [mine(1, 1), mine(1, 2), mine(2, 1)],
    [hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)]).

poss_grid(2,
    [mine(1, 1), mine(1, 3), mine(3, 1)],
    [hint(1, 1, -1), hint(1, 2, 2), hint(1, 3, -1), hint(2, 1, 2), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)]).

poss_grid(3,
    [mine(1, 1), mine(1, 3), mine(2, 1)],
    [hint(1, 1, -1), hint(1, 2, 3), hint(1, 3, -1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)]).

poss_grid(4,
    [mine(1, 1), mine(1, 2), mine(3, 1)],
    [hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, 3), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)]).


/* End Generated Data */

// 9 x 9 x (9 x 4) = 9 x 9 x 36 = 2916
range(grid(X)) :- poss_grid(X, _, _).
range(mine(X, Y)) :- all_locations(X, Y).
range(hint(X, Y, N)) :- all_locations(X, Y) & .member(N, [-1, 0, 1, 2, 3]). // poss_grid(_, _, Hints) & .member(hint(X, Y, N), Hints).


mine(X, Y) :- grid(P) & poss_grid(P, Mines, _) & .member(mine(X, Y), Mines).
hint(X, Y, N) :- grid(P) & poss_grid(P, _, Hints) & .member(hint(X, Y, N), Hints).





/*
Model Creation: Minesweeper Example

 Step 1:
 // 9 x 9 x (9 x 4) = 9 x 9 x 36 = 2916


 range(grid(X)) :- poss_grid(X, _, _).
 range(mine(X, Y)) :- all_locations(X, Y).
 range(hint(X, Y, N)) :- all_locations(X, Y) & .member(N, [-1, 0, 1, 2]). // poss_grid(_, _, Hints) & .member(hint(X, Y, N), Hints).


 R = {grid(X), mine(X, Y), hint(X, Y, N)}

 Range(grid(X)) = {grid(1), grid(2), grid(3), grid(4)}
 Range(mine(X, Y)) = {mine(1, 1), mine(1, 2), mine(1, 3), mine(2, 1), mine(2, 2), ..., mine(3, 3)}
 Range(hint(X, Y, N)) = {hint(1, 1, -1), hint(0, 0, 0), hint(0, 0, 1), hint(0, 0, 2), hint(0, 0, 3), ..., hint(3, 3, 3)}

 VL = {
      {grid(1), mine(1, 1), hint(1, 1, -1)},
      {grid(1), mine(1, 1), hint(0, 0, 0)},
      {grid(1), mine(1, 1), hint(0, 0, 1)},
      {grid(1), mine(1, 1), hint(0, 0, 2)},
      {grid(1), mine(1, 1), hint(0, 0, 3)},
      {grid(1), mine(1, 1), hint(0, 1, 1)},
      ...


      {grid(1), mine(1, 2), hint(1, 1, -1)},
      ...
}

Step 2:

    RPV =
        mine(X, Y) :- grid(P) & poss_grid(P, Mines, _) & .member(mine(X, Y), Mines).


 VL' = {
      v' = {grid(1), mine(1, 1), mine(1, 2), mine(2, 1), hint(1, 1, -1)},
        L = {mine(1, 1), mine(1, 2), mine(2, 1)}
        FindRanges(L) = {mine(1, 1), mine(1, 2), mine(1, 3), mine(2, 1), mine(2, 2), ..., mine(3, 3)}
      ...
      v' = {grid(1), mine(1, 1), mine(1, 2), mine(2, 1), hint(3, 3, 3)},



      v' = {grid(2), mine(1, 1), mine(1, 3), mine(3, 1), hint(1, 1, -1)},
      ...
      v' = {grid(2), mine(1, 1), mine(1, 3), mine(3, 1), hint(3, 3, 3)},


      v' = {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), hint(1, 1, -1)},
            ...
      v' = {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), hint(3, 3, 3)},


      v' = {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), hint(1, 1, -1)},
                  ...
      v' = {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), hint(3, 3, 3)},

}


hint(X, Y, N) :- grid(P) & poss_grid(P, _, Hints) & .member(hint(X, Y, N), Hints).

 VL'' = {
      v' = {grid(1), mine(1, 1), mine(1, 2), mine(2, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)},
        L = {hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)}
        FindRanges(L) = {hint(1, 1, -1), hint(0, 0, 0), hint(0, 0, 1), hint(0, 0, 2), hint(0, 0, 3), ..., hint(3, 3, 3)}



      v' = {grid(2), mine(1, 1), mine(1, 3), mine(3, 1), hint(1, 1, -1), hint(1, 2, 2), hint(1, 3, -1), hint(2, 1, 2), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)},


      v' = {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), hint(1, 1, -1), hint(1, 2, 3), hint(1, 3, -1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)},


      v' = {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, 3), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)}
}


Step 3: Negative Valuations

    RNV =
        ~mine(1, _) :- grid(1) | grid(2). (Not working)
        ~mine(1, X) :- grid(1) | grid(2) & mine(1, X).


 VL' = {
      v' = {grid(1), mine(2, 1), ... },
        L = {~mine(1, 1), ~mine(1, 2)}
        L+ = {mine(1, 1), mine(1, 2)}
        FindRanges(L+) = {mine(1, 1), mine(1, 2), mine(1, 3), mine(2, 1), mine(2, 2), ..., mine(3, 3)}

      v' = {grid(2), mine(3, 1), ...},

      v' = {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), ...},

      v' = {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), ...},
}

Step 4: Creating a Model (Building from VL'' in step 2)

 VL'' = {
      v' = {grid(1), mine(1, 1), mine(1, 2), mine(2, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)},

      v' = {grid(2), mine(1, 1), mine(1, 3), mine(3, 1), hint(1, 1, -1), hint(1, 2, 2), hint(1, 3, -1), hint(2, 1, 2), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)},

      v' = {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), hint(1, 1, -1), hint(1, 2, 3), hint(1, 3, -1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)},

      v' = {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, 3), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)}
}



W = {
      w1,
      w2,
      w3,
      w4
    }

V = {
    w1 -> {grid(1), mine(1, 1), mine(1, 2), mine(2, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)}
    w2 -> {grid(2), mine(1, 1), mine(1, 3), mine(3, 1), hint(1, 1, -1), hint(1, 2, 2), hint(1, 3, -1), hint(2, 1, 2), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)}
    w3 -> {grid(3), mine(1, 1), mine(1, 3), mine(2, 1), hint(1, 1, -1), hint(1, 2, 3), hint(1, 3, -1), hint(2, 1, -1), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, 1), hint(3, 2, 1), hint(3, 3, 0)}
    w4 -> {grid(4), mine(1, 1), mine(1, 2), mine(3, 1), hint(1, 1, -1), hint(1, 2, -1), hint(1, 3, 1), hint(2, 1, 3), hint(2, 2, 3), hint(2, 3, 1), hint(3, 1, -1), hint(3, 2, 1), hint(3, 3, 0)}
}


M = (W, WxW, V),
Pointed Model: (M, w3)
*/




/*
Event Semantics:
    - Consider what happens when there are multiple groundings of a plan with the same event ID
        - Now, what happens if plan has same event ID and context, but different plan body?

+event(e1)
    :   b1(X) & b2(Y) & e1(X, Y) & e2(C)
    <-  -e1(X, Y);
        +e1(X2, Y2).

Groundings:
 (1)
    // Event ID = e1
    // Context: b1(a) & b2(test)
    // Event Pre-Condition: e1(a, test) & e2(t2)
    // Event Post-Condition: {~e1(a, test), ~e1(b, wow), e1(x2, y2)}

    +event(e1) // X = a, Y = test, C = t2, X2 = x2, Y2 = y2
    :   b1(a) & b2(test) & e1(a, test) & e2(t2)
    <-  -e1(a, test);
        -e1(b, wow);
        +e1(x2, y2).

 (2)
    // Event ID = e1
    // Context: b1(b) & b2(wow)
    // Event Pre-Condition: e1(b, wow) & e2(t2)
    // Event Post-Condition: {~e1(b, wow), e1(a, test)}

    +event(e1) // X = a, Y = test, C = t2, X2 = x2, Y2 = y2
    :   b1(a) & b2(test) & e1(a, test) & e2(t2)
    <-  -e1(b, wow);
        +e1(a, test).


Event Model:
    E = {e1}

    Pre(e1) = [e1(a, test) & e2(t2)] |
                    [e1(b, wow) & e2(t2)]

    Effects(e1, e1(a, test) & e2(t2)) = {~e1(a, test), ~e1(b, wow), e1(x2, y2)}
    Effects(e1, e1(b, wow) & e2(t2)) = {~e1(b, wow), e1(a, test)}



Formalize (Definitions):
    1. Get all applicable events (event plans with true context)
        - event_plans = set of applicable plans (note: applicable implies grounded)
            -  .trigger = +event(Id)
            -  .context = context & precondition (context is true at this point)
            -  .body = List of +/- literals

    2. Sets/Functions:
        1. EventIds = {Id | e in event_plans where e.trigger = +event(Id)}}
            - Gets (zero to many) applicable event Ids
        2. EventPlans(Id) = {e : e in event_plans where e.trigger = +event(Id)}
            - Gets (zero to many) applicable plans that match the id
        3. PreCondition(Id) = V(e.context.precondition : e in EventPlans(Id))
            - Pre-Condition function: disjunction of all pre-conditions for event 'Id'
        4. Effects(e) = {l | e in event_plans and +l in e.body} union {~l | e in event_plans and -l in e.body}
            - Convert event body to event effects
        4. PostCondition(Id) = {(cond, l) | e in EventPlans(Id) where cond = e.context.precondition and l in Effects(e) }
             - Post-Condition function: set of conditions and literal changes


Formalize (Semantics):
 - Done in overleaf


Examples:

Beliefs: just_clicked(X, Y)
Epistemic: clicked(X, Y)

Plan Library:

+event(clicked)
    :   just_clicked(X, Y) & ~clicked(X, Y)
    <-  +clicked(X, Y).




// Not an epistemic event (invalid trigger)
+other
    :   just_clicked(X, Y) & ~clicked(X, Y)
    <-  +clicked(X, Y);
        +bel; // Invalid (non-epistemic/belief)
        .call(..); // Invalid

// Not an epistemic event
+event(other)
    :   just_clicked(X, Y) & ~clicked(X, Y)
    <-  +clicked(X, Y);
        +bel; // Invalid (non-epistemic/belief)
        .call(..); // Invalid


=========
Ex 1:
BS:
just_clicked(1, 1)

ES:
~clicked(1, 1)

+event(clicked)
    :   just_clicked(1, 1) & ~clicked(1, 1)
    <-  +clicked(1, 1).

Effects(p1) = {(clicked(1, 1), true)}

e = clicked
E = {clicked}
R = {(clicked, clicked)}
Pre(clicked) = ~clicked(1, 1)
Post(clicked) = {(clicked(1, 1), true)}




    0. Add to applicable event plans and compute effects
        P_E = {
            p1 = +event(clicked) : just_clicked(1, 1) & ~clicked(1, 1) <- +clicked(1, 1).
        }

        Effects(p1) = {(clicked(1, 1), true)}

    1. e1 = clicked, E = {clicked}
    2. Pre(clicked) = ~clicked(1, 1)
    3. Post(clicked, clicked(1, 1)) = true

    Event Model:
    E = {clicked}
    R = ExE
    Pre(clicked) = ~clicked(1, 1)
    Post(clicked, clicked(1, 1)) = true


=========
Ex 2: just_clicked(1, 1), clicked(1, 1)
    0. Add to applicable event plans and compute effects
        Ev = ApplEpiEv(PL) = {}

    1. Continue without events...






TODO: Future Work
    1. Remove support for duplicate plans with same event ID, just choose first plan if multiple are applicable
        - This just complicates semantics and doesn't provide us with much value
    2. Come up with rules for multiple events with overlapping pre-conditions
        - (Because this leads to expansion of worlds)
    3. Do we need to support full expressiveness of post-conditions?
        - I.e., x becomes true if K(y) was previously true at world?
        - When are these types of post-conditions necessary (understand why we may need them)
        - If not necessary, justify why

*/





















