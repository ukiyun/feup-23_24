:- use_module(library(system)).
:- consult('board.pl').

% display pieces on the board

write_char(empty) :- write('   ').          % Where the Board is Empty, i.e., No Pawns Occupying that Space, the Program Will Show just a Blank Space
write_char(b) :- write(' B ').              % Where the Blue Pawns, their position in the Board will be Marked by ' B '
write_char(r) :- write(' R ').              % Where the Red Pawns, their position in the Board will be Marked by ' R '
write_char(division) :- write('|').         % Formatting For the Board

% Attributes a Player to a Piece, so, Player1 is going to be the Red Pawns and Player2 the BluePawns
player_piece(Piece, Player):-           
    (
        Player == 1                          
    ->  Piece = r
    ;   Player == 2 
    ->  Piece = b
    ).


% Predicate to display the board.
display_board(Board) :- nl,nl,nl,
                        write('    1   2   3   4   5   6   7   8\n'),               % Column Indexes
                        write('  |---|---|---|---|---|---|---|---|\n'),
                        print_board(Board, 1),
                        nl.

% Predicate to print the board.
print_board([], _).
print_board([Row|Rest], RowNum) :-
    write(RowNum), write(' |'), print_row(Row),write('\n'),write('  |---|---|---|---|---|---|---|---|\n'),          % Row Indexes
    NextRowNum is RowNum + 1,                                                                                       
    print_board(Rest, NextRowNum).

% Predicate defining what print_row(Row) does
print_row([]).
print_row([Cell|Rest]) :-
    write_char(Cell), write_char(division),
    print_row(Rest).


% ======================================================= %


% Displaying the cards with specific paths, There are a total of 12 different Paths for the User to Choose


% Card with ID 1
display_card(1) :-                                  
    nl,nl,
    print('[1]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X | X |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 2
display_card(2) :-                                  
    nl,nl,
    print('[2]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 3
display_card(3) :-                                  
    nl,nl,
    print('[3]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 4
display_card(4) :- 
    nl,nl,
    print('[4]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 5
display_card(5) :- 
    nl,nl,
    print('[5]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X | X |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 6
display_card(6) :- 
    nl,nl,
    print('[6]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 7
display_card(7) :- 
    nl,nl,
    print('[7]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 8
display_card(8) :- 
    nl,nl,
    print('[8]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 9
display_card(9) :- 
    nl,nl,
    print('[9]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 10
display_card(10) :- 
    nl,nl,
    print('[10]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 11
display_card(11) :- 
    nl,nl,
    print('[11]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('| X | X | X | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   | X |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('| X |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% Card with ID 12
display_card(12) :- 
    nl,nl,
    print('[12]'),nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   |   | X |   |   |'), nl,
    print('|---|---|---|---|---|'), nl,
    print('|   | X |   |   |   |'), nl,
    print('|---|---|---|---|---|'), nl.


% ======================================================= %

% Used to Show whose turn it is next.
display_players_turn(Player):-
    (
        Player == 1
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|              RED PLAYERS TURN              |'), nl,
        print('|____________________________________________|')
    
    ;   Player == 2
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|              BLUE PLAYERS TURN             |'), nl,
        print('|____________________________________________|')
    ).


    
% ======================================================= %

% Displays the Current Round, a Round Passes when both player have switched a pawn out of position and discarded said Path
display_current_round(Round):-
    nl,nl,
    print(' ______________________ '), nl,
    print('|                      |'), nl,
    format('         ROUND ~d        ', [Round]), nl, 
    print('|______________________|'),nl,nl.
    


% ======================================================= %

% Displays the Outcome of the Game. Either Blue or Red wins, or they draw 
display_winner(Winner):-
    (
        Winner == 1
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|               RED PLAYER WINS!             |'), nl,
        print('|____________________________________________|')
    
    ;   Winner == 2
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|               BLUE PLAYER WINS!            |'), nl,
        print('|____________________________________________|')

    ;   Winner == 3
    ->  print(' ____________________________________________ '), nl,
        print('|                                            |'), nl,
        write('|                 ITS A DRAW!                |'), nl,
        print('|____________________________________________|')    
    ).
