:- dynamic round/4.

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).

% style_round_number(?DanceStyle, ?RoundNumber)
style_round_number(DanceStyle, RoundNumber):-
    (
        DanceStyle == NULL
        -> round(RoundNumber, Style, Minutes, [Dancer1|Dancer2]),   DanceStyle = Style     
        ; round(Round, DanceStyle, Minutes, [Dancer1|Dancer2]), RoundNumber = Round
    ).

% n_dancers(?RoundNumber, -NDancers)
n_dancers(RoundNumber, NDancers):-
    round(RoundNumber, DanceStyle, Minutes, Dancers),
    length(Dancers, NDancers).

% danced_in_round(?RoundNumber, ?Dancer)
write_dancers(Dancer):-
    Dancer = [Dancer1 | Rest],
    write(Dancer1),
    (
        Rest == NULL
        -> write('No more Dancers!'), nl, abort
        ; write_dancers(Rest)
    ).
        

danced_in_round(RoundNumber, Dancer):-
    (
        round(RoundNumber, DanceStyle, Minutes, Dancers),
        write_dancers(Dancers)
    ).
