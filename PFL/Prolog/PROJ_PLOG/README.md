# Traxit Board Game

## Team Members

Group Traxit_1:

| Name                         | UP            | Contribution |
| ------------                 | ------------  |------------  |
| Daniel Dória Pinto           | [up202108808] |50%           |
| Mariana Marujo Conde         | [up202108824] |50%           |



## Game Picked :

##  <p style="text-align: center;">[TRAXIT](https://boardgamegeek.com/boardgame/392652/traxit) </p>


## Getting Started

1. Install a Prolog Interpreter / Compiler, e.g, from the [SICStus Website](https://sicstus.sics.se/download4.html) by following the provided instructions.

2. Once the Interpreter is installed, download the zipped folder containing the game files, and unzip it.
<br>
<br>



<p float="center">
  <img src="https://www.guru99.com/images/3/download-files-from-github-9.png" width="300" />
  <img src="https://allthings.how/content/images/wordpress/2021/08/allthings.how-how-to-unzip-files-in-windows-11-image.png" width="400" />
</p>

<br>
<br>

## Installing the Game

- To install it, just compile the file menu.pl in the Prolog Interpreter, every other file should be loaded automatically.

<br>

## Starting the Game

- In the Compiler, just type :

```prolog
?- play.
```
- **NOTE** : each time you input an instruction or move in the interpreter, don't forget to end the phrase always with a *full stop* !

- The rest of the game is rather intuitive, just follow along the instructions provided.

<br>

## Game Description

- Traxit is an abstract board game where your main goal is to have your pawn stay as close to the top as possible, in the rounds that matter.


### The Board
- The board is an 8 x 8, where each layer / level is worth a different amount of points.



```prolog
     |---|---|---|---|---|---|---|---| 
     | X | X | X | X | X | X | X | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | O | O | O | O | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | W | W | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | A | A | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | A | A | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | W | W | W | W | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | O | O | O | O | O | O | X | 
     |---|---|---|---|---|---|---|---| 
     | X | X | X | X | X | X | X | X | 
     |---|---|---|---|---|---|---|---| 
```

<br>

- **X's** are worth 0 points

- **O's** are worth 25 points

- **W's** are worth 50 points

- **A's** are worth 100 points


### Cards

- Each Player has 2 pawns and a total of 12 different path tiles.
- These tiles are unique and you can rotate the path as freely as you'd like.
- After using a Path, the corresponded tile is discarded.

### Score & Rounds 

- There are a total of 12 rounds and at the end of every 4 rounds (4, 8, 12) you score points based on the position of both your pawns.

- You can't move outside the board, and if you can't move at all, the opponent takes one of your pawns and moves it to the lowest level. This move is called a ***Traxit***, which is the latin word for being pulled.

- At the end of all rounds, the points are tallied up and the person with the highest score wins!


### Game Logic

#### Internal Representation of the Game State : 

- **Board**
    - The current state is represented by a list of lists, in which every single one of the rows corresponds to a row in the game board.


- Initial State :

```prolog

initialBoard([

            [ empty , empty , b , empty , empty , b , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , r , empty , empty , r , empty , empty ],
            ]).
```

- Example of an Intermediate State :

```prolog

([

            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , r , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , r , empty , b , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , b , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            ]).
```

- Example of a Final State :

```prolog

([

            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , r , b , empty , empty , empty ],
            [ empty , empty , empty , empty , b , empty , empty , empty ],
            [ empty , empty , r , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            [ empty , empty , empty , empty , empty , empty , empty , empty ],
            ]).
```

##### - Description :

r → red pawn (R)

b → blue pawn (B)

empty → space with no pawns

<br>

<br>


- Each time a Player makes a play, a new Board is created with the same characteristics of the one initialized in the beginning, however, the pawn disposition is updated to the one intended by the Player.

The management of whose turn it is to play and the cards still available, as well as the total number of rounds, during the whole game, is done by different instances in the main loop of the game:

```prolog
        game_loop(Player, Board, BlueCards, RedCards, Round)
```



<br>

- **Player**
    - In the game_loop predicate, Player equates to the current player is, i.e., whose turn is it to play. The BlueCards and RedCards correspond to the cards that each player still has available for the rest of the match.


#### Game State Visualization :

- Every time the game comes back to Player 1 (Blue), a new round begins. With that in mind, in the beginning of every iteration of the game loop, where the Player is the Blue, the predicate display_current_round(Round) is called, so that the players are up to date to which Round they are in.

- Besides that, it is imperative to specify which Player's turn it is, so using the predicate display_players_turn(Player), the game prints out a message, informing the Player's about whose turn it is to play.

- Given that our games current state is represented by the Board, in the beginning of every round, the predicate display_board(Board) to show the Players the current Board.

    -This function does a cycle in which it calls the predicates print_board(List, RowNum) and print_row(List) as auxiliaries to draw the current state of the board.

- The display_board(Board) first prints ou the columns of the board, and at the first line of cell separation. Then it calls print_board(List, RowNum) that is responsible for printing the rows of the Board and their respective numbers, with the help of print_row(List).

- Due to the specifications of our game, the Board cannot have a variable size, since it's reliant on the positioning of the paws, to be counted the points of each player.


#### Execution of Plays:

- The play execution begins with the current state of the board to be shown to the user, so that they can choose what kinda of play they'd like to do.

- Then after that, comes the choice of movement, since that for the execution of a play it is necessary for the user to choose their pawn ( through the column and row).

```prolog
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
```

- There are checks made to the piece that the player chooses, in order to guarantee that the pieces in did exists and belongs to them, and to know where it is going to be moved to, there's a need to choose the card with a path :

```prolog
    display_card_numbers(Cards) :-
        sleep(0.8),                             % Sleep to give the user time to read the board
        write('Your Cards: '),                  % Display the message
        display_card_numbers_aux(Cards).        % Call the auxiliary predicate

    display_card_numbers_aux([]) :- nl.                     % Base case: Display a new line
    display_card_numbers_aux([[Number, _] | Rest]) :-       % Recursive case: Displays the Card(defined in is display.pl) and calls the predicate again
        display_card(Number),                               % When the Number is Input, the Card that is displayed is the one that corresponds to the Number
        sleep(0.4),
        display_card_numbers_aux(Rest).
```

- To verify the validity of a play, we use the Predicate sum_coords(Card, ReturnRow, ReturnColumn, List, Board), where the Board argument is the current Board and how the pawns are layed out, before the validation of the play. ReturnRow and ReturnColumn point to the future position of the pawn, if the movement is validated. For that, it is necessary that both values be between 1 and 8 and that the cell where the pawn is going to go is in fact empty. To verify if the cell is empty the Predicate Empty(Board,Row,Column) is called that returns a boolean value depending on wether the cell is empty or not.

- After this, if the play is invalidated, new information will be asked of the Player, Meaning if it is valid, the Movement is executed.

- After this process, all the available coordinates for where the pawn can go are presented, always keeping in mind the coordinates of the Board. Then the Player of the respective turn can decide where their piece goes to, having in mind the Card selection made by the opponent.

- When the movement is done, the List of Available Cards is updated using remove_card(Id, Cards, RemainingCards).

```prolog
    remove_card(_, [], []).
    remove_card(Id, [[Id, _] | Tail], RemainingCards) :-
        !, remove_card(Id, Tail, RemainingCards).
	remove_card(Id, [Card | Tail], [Card | RemainingCards]) :-
        remove_card(Id, Tail, RemainingCards).

```


- After removing the card, the Board gets updated with the new Position of the Paw by calling these two predicates: 

```prolog
    remove_piece(Board, Row, Col, NewBoard) :-
        nth1(Row, Board, BoardRow),
        replace(BoardRow, Col, empty, NewRow),
        replace(Board, Row, NewRow, NewBoard).

    change_cell(Board, Row, Col, NewValue, NewBoard) :-
        nth1(Row, Board, OldRow),
        replace(Old, Col, NewValue, ModifiedRow),
        replace(Board, Row, ModifiedRow, NewBoard).
```

- As an auxiliary we needed to also create replace.

```prolog
    replace([_|T], 1, X, [X|T]).
    replace([H|T], I, X, [H|R]):-
        I > 1,
        I1 is I - 1,
        replace(T, I1, X, R).

```

- To end the cicle, the Player id is switch and if it switches from the Blue Player to the Red Player, we add 1 to the number of the round and run the same cycle with the arguments updated.


#### Game Ending:

- For the game to end, once there is no removing pieces of the Board nor captures, it just need to reach the round limit, which in this case is Round 12. The End of the Game is detected by:

```prolog
    game_loop(Board,_,7,_,_) :- 
display_board(Board), 
display_winner(Winner).


display_winner(Winner) :- 
(
 	Winner == 1
    ->	print(‘________________________________’),nl,
        print(‘|                              |’),nl,
        write(‘|       RED PLAYER WINS!       |’),nl,
        print(‘|______________________________|’),nl,
    ;	Winner == 2
    ->	print(‘________________________________’),nl,
        print(‘|                              |’),nl,
        write(‘|      BLUE PLAYER WINS!       |’),nl,
        print(‘|______________________________|’),nl,
    ;	Winner == 3
    ->	print(‘________________________________’),nl,
        print(‘|                              |’),nl,
        write(‘|          ITS A DRAW          |’),nl,
        print(‘|______________________________|’),nl,
).

```