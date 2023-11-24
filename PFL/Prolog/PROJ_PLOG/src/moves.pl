:- use_module(library(system)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).

:- consult('rules.pl').
:- consult('display.pl').

:- dynamic list_indexes/1.          % Dynamic predicate to store the indexes of the possible moves of a piece 

% ======================================================= %

% Card Paths

% Structure of the cards: [CardNumber, [[X1, Y1], [X2, Y2], ...]]
% The cards are represented by a list of lists, where each list is a card and the first element is the card number and the second element is the list of coordinates
% The Last Element of cards() is the player that has the cards
cards([
    [1, [[4,2], [4,-2], [-4,2], [-4,-2], [2,4], [2,-4], [-2,4], [-2,-4]]],
    [2, [[3,0], [-3,0], [0,3], [0,-3]]],
    [3, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [4, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [5, [[4,0], [-4,0], [0,4], [0,-4]]],
    [6, [[3,2], [3,-2], [-3,2], [-3,-2], [2,3], [2,-3], [-2,3], [-2,-3]]],
    [7, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [8, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [9, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [10, [[2,2], [-2,2], [-2,-2], [2,-2]]],
    [11, [[2,3], [-2,3], [-3,2], [2,-3], [-2,-3], [3,-2], [-3,-2], [3,2]]],
    [12, [[1,1], [-1,1], [-1,-1], [1,-1]]]
    ], 1).


%blue cards
cards([
    [1, [[4,2], [4,-2], [-4,2], [-4,-2], [2,4], [2,-4], [-2,4], [-2,-4]]],
    [2, [[3,0], [-3,0], [0,3], [0,-3]]],
    [3, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [4, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [5, [[4,0], [-4,0], [0,4], [0,-4]]],
    [6, [[3,2], [3,-2], [-3,2], [-3,-2], [2,3], [2,-3], [-2,3], [-2,-3]]],
    [7, [[3,-1], [3,1], [-3,-1], [-3,1], [1,3], [1,-3], [-1,3], [-1,-3]]],
    [8, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [9, [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]],
    [10, [[2,2], [-2,2], [-2,-2], [2,-2]]],
    [11, [[2,3], [-2,3], [-3,2], [2,-3], [-2,-3], [3,-2], [-3,-2], [3,2]]],
    [12, [[1,1], [-1,1], [-1,-1], [1,-1]]]
    ], 2).

% ======================================================= %


% Predicate to select a piece at a specific row and column on the board.
select_piece(Board, Row, Col, Piece) :-
    nth1(Row, Board, BoardRow),  % Select the row using nth1/3
    nth1(Col, BoardRow, Piece).  % Select the element in the row using nth1/3


% Predicate to change the value of a cell at a specific row and column in the board.
change_cell(Board, Row, Col, NewValue, NewBoard) :-
    nth1(Row, Board, OldRow),                       % Select the row using nth1/3
    replace(OldRow, Col, NewValue, ModifiedRow),    % Replace the element in the row using replace/4
    replace(Board, Row, ModifiedRow, NewBoard).     % Replace the row in the board using replace/4

% Helper predicate to replace an element in a list at a given position.
replace([_|T], 1, X, [X|T]).    
replace([H|T], I, X, [H|R]) :-      % I > 1, decrement I, and recurse on the tail.
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).


% Predicate to remove a piece at a specific row and column on the board
remove_piece(Board, Row, Col, NewBoard) :-
    nth1(Row, Board, BoardRow),             % Select the row using nth1/3
    replace(BoardRow, Col, empty, NewRow),  % Replace the element in the row using replace/4
    replace(Board, Row, NewRow, NewBoard).  % Replace the row in the board using replace/4    

% ======================================================= %

% Predicate to Show the Users Available Cards


display_card_numbers(Cards) :-
    sleep(0.8),                             % Sleep to give the user time to read the board
    write('Your Cards: '),                  % Display the message
    display_card_numbers_aux(Cards).        % Call the auxiliary predicate

display_card_numbers_aux([]) :- nl.                     % Base case: Display a new line
display_card_numbers_aux([[Number, _] | Rest]) :-       % Recursive case: Displays the Card (defined in is display.pl) and calls the predicate again
    display_card(Number),                               % When the Number is Input, the Card that is displayed is the one that corresponds to the Number
    sleep(0.4),
    display_card_numbers_aux(Rest).

% ======================================================= %


% Predicate That Makes the Game Loop (Main Game Predicate), and makes the game playable 

game_loop(Player, Board, BlueCards, RedCards, Round) :-
    (
        Player = 1                      % If the Player is 1, then the Cards are BlueCards, else they are RedCards
    ->  Cards = BlueCards 
    ;   Cards = RedCards
    ),

    (
    Player == 1 -> display_current_round(Round)         % Display the Current Round, Only if the Player is 1, because the Round only changes when they both have played
    ; true
    ),

    display_players_turn(Player),                       % Display the Player's Turn
    display_board(Board),                               % Display the Current Board
    check_starting_position(Board, Column, Row, Player, ReturnRow, ReturnColumn),       % Check if the Starting Position is Valid, This Predicate is used to let the user choose a piece to move
    
    display_card_numbers(Cards),                % Display the Cards that the Player has
    write('Choose a card to use: \n'),          % Ask the Player to Choose a Card
    read(Id),nl,                                % Read the Card Number

    (is_valid_card_number(Id, Cards) ->                                     % Check if the Card Number is Valid
        true                                                                % If it is, then continue
    ;
        write('Invalid card number. Please select a valid card.\n'),        % If it isn't, then display an error message and retry the turn
        sleep(3),
        game_loop(Player, Board, BlueCards, RedCards, Round) % Retry the turn
    ), 


    get_card_by_id(Id, Cards, Card),                    % Get the Card by its ID

    nl, write('Final coords can be:'), nl,nl,           % Display the Possible Final Coordinates of the Piece based on the Card that was chosen
    write(' Row   |   Col'),nl,

    initialize_indexes,                                                 % Initialize the List of Possible Final Coordinates
    sum_coords(Card, ReturnRow, ReturnColumn, List, Board), nl,         % Sum the Coordinates of the Card with the Starting Position to get the Possible Final Coordinates
    list_indexes(List),                                                 % Get the List of Possible Final Coordinates
    reverse(List, FinalList), nl,                                       % Reverse the List of Possible Final Coordinates to make it easier to select the Final Coordinates

    write('Select the desired coordinates: '), read(Number),nl,         % Ask the Player to Select the Final Coordinates
   
    nth1(Number, FinalList, FinalCoords),                               % Get the Final Coordinates by the Number that the Player Selected, starting at 1
    [FinalRow, FinalColumn] = FinalCoords,                              % Get the Final Row and Column from the Final Coordinates

    remove_card(Id, Cards, RemainingCards),                             % Remove the Card that was used from the Player's Cards

    player_piece(Piece,Player),                                                 % Get the Piece that corresponds to the Player

    remove_piece(Board, ReturnRow, ReturnColumn, TempBoard),                    % Remove the Piece from the Starting Position
    change_cell(TempBoard, FinalRow, FinalColumn, Piece, NewBoard),             % Place the Piece in the Final Position

    nl,nl,nl,

    (Player = 1 -> NextPlayer = 2; NextPlayer = 1, NextRound is Round + 1),     % If the Player is 1, the next Player will be 2 and vice-versa, and if the Player is 1, the Round will be incremented, since it means that both players have played
    (Player = 1 -> game_loop(NextPlayer, NewBoard, RemainingCards, RedCards, Round); game_loop(NextPlayer, NewBoard, BlueCards, RemainingCards, NextRound)).        % Call the Game Loop again with the New Board, the Remaining Cards and the Next Player


% ======================================================= %


% Predicate to obtain the card by its ID
get_card_by_id(Id, [[Id, Coords] | _], Coords) :- !.
get_card_by_id(Id, [_ | Tail], Coords) :-
    get_card_by_id(Id, Tail, Coords).
    

% remove_card(+CardId, +Cards, -RemainingCards)
remove_card(_, [], []).
remove_card(Id, [[Id, _] | Tail], RemainingCards) :-
    !, remove_card(Id, Tail, RemainingCards).
remove_card(Id, [Card | Tail], [Card | RemainingCards]) :-
    remove_card(Id, Tail, RemainingCards).


% Predicate to sum the coordinates of the card with the starting position to get the possible final coordinates
sum_coords([], _, _,_, _).
sum_coords([[X, Y] | Tail], StartRow, StartCol, Indexs, Board) :-
    NewSumX is StartRow + X,                            % Sum the X coordinate of the Card with the Starting Row
    NewSumY is StartCol + Y,                            % Sum the Y coordinate of the Card with the Starting Column

    (
        (isEmpty(Board, NewSumX, NewSumY), NewSumX > 0, NewSumX =< 8, NewSumY > 0, NewSumY =< 8)
    ->  write('    [ '), write(NewSumX), write(', '), write(NewSumY), write(']'),nl,
        Coordinates = [NewSumX,NewSumY],        % If the New Coordinates are Valid, then add them to the List of Possible Final Coordinates
        add_to_list(Coordinates)                
    ;   true 
    ),

    sum_coords(Tail, StartRow, StartCol, ValidIndexes, Board).      % Call the Predicate again with the Tail of the Card List


% ======================================================= %

% Predicate to initialize the list of possible final coordinates
initialize_indexes :-
    reset_list.

% Predicate to add an element to the list of possible final coordinates
add_to_list(X) :-
    retract(list_indexes(List)),
    assert(list_indexes([X | List])).

% Predicate to reset the list of possible final coordinates
reset_list :-
    retractall(list_indexes(_)),
    assertz(list_indexes([])).


% ======================================================= %

% Predicate to check the starting position of the piece that the player wants to move
check_starting_position(Board, Column, Row, Player, ReturnRow, ReturnColumn) :-
    nl, write('Choose a piece to move: '),nl,
    write('\nColumn: '),
    checkColumn(ValidColumn, InputColumn),              % Check if the Column is Valid
    write('\nRow: '),
    checkRow(ValidRow, InputRow),                       % Check if the Row is Valid
    nth1(InputRow, Board, RowList),
    nth1(InputColumn, RowList, Piece),
    % convert the user input to
    (
        (Piece == 'r' ; Piece == 'b') ->                % Check if the Piece is Valid
        (
            (Piece == 'r'->                             % Check if the Piece belongs to the Player that selected it
                Pieces = 1
            ;   Pieces = 2),

            (Pieces == Player)->                        
            (   
                ReturnColumn is InputColumn,            
                ReturnRow is InputRow,
                write('\nYour turn to make a move!\n'), nl          
            )
            ;
            write('\nNot your piece! That piece belongs to the other player!\n'),
            write('\nTry again!\n'),
            check_starting_position(Board, Column, Row, Player)         % If the Piece doesn't belong to the Player, then display an error message and retry the turn
        )
        ;
        write('\nNo piece in that position!\n'),
        check_starting_position(Board, Column, Row, Player)             % If there is no Piece in the Starting Position, then display an error message and retry the turn
    ).


% ======================================================= %

% Check if the Card Number is Valid
is_valid_card_number(Id, Cards) :-          
    member([Id, _], Cards).

% ======================================================= %
