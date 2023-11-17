% a)

%   pilots (pilot)
pilots(lamb).
pilots(besenyei).
pilots(chambliss).
pilots(maclean).
pilots(mangold).
pilots(jones).
pilots(bonhomme).

%   teams (pilot, team)
teams(lamb, breitling).
teams(besenyei, redBull).
teams(chambliss, redBull).
teams(maclean, mediterraneanRacingTeam).
teams(mangold, cobra).
teams(jones, matador).
teams(bonhomme, matador).

%   planes (pilot, plane model)
planes(lamb, mx2).
planes(besenyei, edge540).
planes(chambliss, edge540).
planes(maclean, edge540).
planes(mangold, edge540).
planes(jones, edge540).
planes(bonhomme, edge540).

%   circuits (city)
circuits(instanbul).
circuits(budapest).
circuits(porto).

%   gates (circuit_city , number of gates)
gates(instanbul, 9).
gates(budapest, 6).
gates(porto, 5).

%   winners (pilot, circuit_city)
winners(mangold, instanbul).
winners(mangold, budapest).
winners(jones, porto).

% which team X won Y event
teamWon(X,Y) :- winners(P, Y), teams(P, X).


% b)
/*

i.  |?- winners(W, porto).                                      W = jones
ii. |?- teamWon(T, porto).                                      T = matador
iii.|?- gates(C, 9).                                            C = instanbul
iv. |?- pilots(P, A), A\=edge540.                               P = lamb, A = mx2
v.  |?- winners(P, C1), winners(P, C2), C1\=C2.                 P = mangold, C1 = instanbul, C2 = budapest
vi. |?- winners(P, porto), planes(P, A).                        P = jones, A = edge540

*/