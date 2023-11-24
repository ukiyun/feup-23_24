:- use_module(library(random)).
:- use_module(library(lists)).
:- consult('board.pl').


% Choose a random player to start the game

% choosePlayer(+PlayerOne, +PlayerTwo, -FirstToPlay)
choosePlayer(PlayerOne, PlayerTwo, FirstToPlay):-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% ======================================================= %

% Check if a row is valid

% checkRow(+IsValid, -Row)
checkRow(IsValid, Row):-
    repeat,                                                 % repeat until valid input
    read(Number),                                           % read User input
    (
       memberchk(Number,[1,2,3,4,5,6,7,8])                  % check if input is valid, i.e. between 1 and 8
    -> IsValid = 'True', Row = Number, !, true              % if valid, return true and the row number
    ; write('Invalid Row\n'), IsValid = 'False'             % if not valid, return false
    ).

% ======================================================= %

% Check if a column is valid

% checkColumn(+IsValid, -Column)
checkColumn(IsValid, Column):-                              
    repeat,                                                         % repeat until valid input
    read(Number),                                                   % read User input
    (
       memberchk(Number,[1,2,3,4,5,6,7,8])                          % check if input is valid, i.e. between 1 and 8
    -> IsValid = 'True', Column = Number, !, true                   % if valid, return true and the column number
    ; write('Invalid Column\n'), nl, IsValid = 'False'              % if not valid, return false
    ).


% ======================================================= %

% check if the destination piece is empty
isEmpty(Board, Row, Column) :-
    nth1(Row, Board, RowList),          
    nth1(Column, RowList, Value),       
    Value == empty.

% ===================== BOARD ITERATION ========================= %


% Find all coordinates of a specific piece on the board
find_all_coordinates(Board, Piece, Coordinates) :-
    find_all_coordinates(Board, 1, 1, Piece, [], Coordinates).

find_all_coordinates([], _, _, _, Coordinates, Coordinates).
find_all_coordinates([Row | Rest], RowIndex, ColIndex, Piece, Acc, Coordinates) :-
    find_piece_in_row(Row, RowIndex, 1, ColIndex, Piece, [], RowCoords),
    NextRowIndex is RowIndex + 1,
    append(Acc, RowCoords, NewAcc),
    find_all_coordinates(Rest, NextRowIndex, ColIndex, Piece, NewAcc, Coordinates).

find_piece_in_row([], _, _, _, _, Coordinates, Coordinates).
find_piece_in_row([Piece | Rest], RowIndex, ColIndex, ColCount, Piece, Acc, Coordinates) :-
    append(Acc, [(RowIndex, ColIndex)], NewAcc),
    NextColCount is ColCount + 1,
    find_piece_in_row(Rest, RowIndex, ColIndex, NextColCount, Piece, NewAcc, Coordinates).
find_piece_in_row([_ | Rest], RowIndex, ColIndex, ColCount, Piece, Acc, Coordinates) :-
    NextColIndex is ColIndex + 1,
    find_piece_in_row(Rest, RowIndex, NextColIndex, ColCount, Piece, Acc, Coordinates).


% ===================== BOARD ITERATION ========================= %

% Since the Game Score is calculated every 4 rounds, this predicate is called every 4 rounds
everyFourth(Round, Board) :-
    (
        Round >= 4
        -> (
            Round mod 4 =:= 0
            -> pointsCalculations(Board),nl
            ; true 
        )
        ; true
    ).

% Predicate that calculates the points of each player
pointsCalculations(Board, PointsRed, PointsBlue) :-
    % find all coordinates for red pieces
    find_all_coordinates(Board, r, RedCoordinates),
    % write('This is where the red pieces are: '), nl,
    [(Uno), (Dos)] = RedCoordinates,        % get the coordinates of the two red pieces
    write(RedCoordinates),nl,               % print the coordinates of the red pieces

    % find all coordinates for blue pieces
    find_all_coordinates(Board, b, BlueCoordinates),
    write('This is where the blue pieces are: '), nl,
    [(One), (Two)] = BlueCoordinates.           % get the coordinates of the two blue pieces
    write(BlueCoordinates), nl.                 % print the coordinates of the blue pieces


% Predicate that calculates the points of each Piece, based on the coordinates
get_coord_points(X,Y,Points) :-
(
    Row == 1 -> Points is 0                 % if the piece is on the first row, it has 0 points
        ; X == 2 -> (                       % if the piece is on the second row
            Y == 1 -> Points is 0           % if the piece is on the first column, it has 0 points
            ; Y == 8 -> Points is 0         % if the piece is on the last column, it has 0 points   
            ; Points is 25                  % if the piece is between the second and seventh column,in row 2, it has 25 points
        )
        ; X == 3 -> (                       % if the piece is on the third row
            Y == 1 -> Points is 0           % if the piece is on the first column, it has 0 points
            ; Y == 8 -> Points is 0         % if the piece is on the last column, it has 0 points
            ; Y == 2 -> Points is 25        % if the piece is on the second or seventh column, it has 25 points
            ; Y == 7 -> Points is 25        
            ; Points is 50                  % if the piece is between the third and sixth column, it has 50 points
        )
        ; X == 4 -> (                       % if the piece is on the fourth row
            Y == 1 -> Points is 0           % if the piece is on the first or last column, it has 0 points
            ; Y == 8 -> Points is 0             
            ; Y == 2 -> Points is 25        % if the piece is on the second or seventh column, it has 25 points        
            ; Y == 7 -> Points is 25
            ; Y == 3 -> Points is 50        % if the piece is on the third or sixth column, it has 50 points    
            ; Y == 6 -> Points is 50            
            ; Points is 100                 % if the piece is between the fourth and fifth column, it has 100 points
        )
        ; X == 5 -> (                       % if the piece is on the fifth row
            Y == 1 -> Points is 0           % if the piece is on the first or last column, it has 0 points      
            ; Y == 8 -> Points is 0
            ; Y == 2 -> Points is 25        % if the piece is on the second or seventh column, it has 25 points
            ; Y == 7 -> Points is 25
            ; Y == 3 -> Points is 50        % if the piece is on the third or sixth column, it has 50 points
            ; Y == 6 -> Points is 50        
            ; Points is 100                 % if the piece is between the fourth and fifth column, it has 100 points
        )
        ; X == 6 -> (                       % if the piece is on the sixth row
            Y == 1 -> Points is 0           % if the piece is on the first or last column, it has 0 points
            ; Y == 8 -> Points is 0
            ; Y == 2 -> Points is 25        % if the piece is on the second or seventh column, it has 25 points
            ; Y == 7 -> Points is 25    
            ; Points is 50                  % if the piece is between the third and sixth column, it has 50 points
        )
        ; X == 7 -> (                       % if the piece is on the seventh row
            Y == 1 -> Points is 0           % if the piece is on the first or last column, it has 0 points
            ; Y == 8 -> Points is 0
            ; Points is 25                  % if the piece is between the second and seventh column, it has 25 points
        )
        ; X == 8 -> Points is 0             % if the piece is on the last row, it has 0 points
    ).

