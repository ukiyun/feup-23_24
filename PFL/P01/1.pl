% a)

female(grace).
female(dede).
female(gloria).
female(barb).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).


parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(gloria, manny).
parent(javier, manny).

parent(barb, cameron).
parent(merle, cameron).

parent(barb, pameron).
parent(merle, pameron).

parent(phil, haley).
parent(claire, haley).

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(mitchell, lily).
parent(cameron, lily).

parent(mitchell, rexford).
parent(cameron, rexford).

parent(pameron, calhoun).
parent(bo, calhoun).

parent(haley, george).
parent(dylan, george).

parent(haley, poppy).
parent(dylan, poppy).

% b)

/*

i.          | ?- female(haley).                         yes
ii.         | ?- male(gil).                             no
iii.        | ?- parent(frank,phil).                    yes
iv.         | ?- parent(P, claire).                     P = dede , n = more choices, P = jay, n , no
v.          | ?- parent(gloria, C).                     C = joe, n, C = manny, n, no
vi.         | ?- parent(jay, S), parent(S, C).          S = claire, C = haley, n, S = claire, C = alex, n, S = claire, C = luke, n, S = mitchell, C = lily, n, S = mitchell, C = rexford, n, no 
vii.        | ?- parent(P, lily), parent(GP, P).        P = mitchell, GP = dede, n, P = mitchell, GP = jay, n, P = cameron, GP = barb, n, P = cameron, GP = merle, n, no 
viii.       | ?- parent(alex, C).                       no
ix          | ?

*/

% c)

% RULES

% parents
father(X,Y):- parent(X,Y), male(X).
mother(X,Y):- parent(X,Y), female(X).

% grandparents
grandparent(X,Y):- parent(X,Y), parent(Y, Z).
grandfather(X,Y):- parent(X,Y), parent(Y, Z), male(X).
grandmother(X,Y):- parent(X,Y), parent(Y, Z), female(X).

% same mother/ father
samemother(X,Y):- mother(M,X), mother(M, Y).
samefather(X,Y):- father(F,X), father(F, Y).

% sibling / half-siblings
siblings(X,Y):- samemother(X,Y), samefather(X,Y), X\=Y.
halfsiblings(X,Y):- (samefather(X,Y), mother(M,X), mother(MM, Y), M\=MM);(samemother(X,Y), father(F,X), father(FF, Y), F\=FF).

% extended family
cousins(X,Y):- parent(U, X), parent(A, Y), siblings(U,A).
uncle(X,Y):- male(X), parent(Z,Y), siblings(X,Z).
aunt(X,Y):- female(X), parent(Z,Y), siblings(X,Z).


% d)

/*

i. 'are Haley and Lily cousins?'            | ?- cousins(haley, lily).      true
ii. 'whos is Luke's father?'                | ?- father(F, luke).           F = phil, n, no
iii. 'who is Lily's uncle?'                 | ?- uncle(U, lily).            no
iv. 'who is a grandmother?'                 | ?- grandmother(GM, _).        GM = grace, n * 3, GM = dede, n * 5, GM = barb, n * 3, no
v.   list all pairs of siblings             | ?- siblings(A, B).            A = claire, B = mitchell, n, A = cameron, B = pameron, n, A = george, B = poppy, n, A = claire, B = mitchell, n, no   
vi.  list all pairs of half-siblings        | ?- halfsiblings(A, B).            A = claire, B = joe, n, A = mitchell, B = joe, n, A = manny, B = joe, n, no


*/

% e)

married(jay, gloria, 2008).
married(jay, dede, 1968).
divorced(jay, dede, 2003).
