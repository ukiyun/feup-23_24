:- consult('game.pl').
:- consult('display.pl').
:- consult('moves.pl').

% =============================================================== %
              
% Displays the Starting Screen as Soon as User inputs play/0.

print_menu :-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                   TRAXIT                   |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|                 1 - Play                   |'), nl,
    print('|                 2 - How to play            |'), nl,
    print('|                 3 - Exit                   |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl,
    print('                                              '), nl.

menu_option(3):- print_exit.                % Will take the User's to The Exit Screen
menu_option(1):- play_menu.                 % Will take the User's to The Playing and Playing Options Screen
menu_option(2):- print_how_to_play.         % Will take the User's to The How to Play Screen, with various instructions


% =============================================================== %

% Displays the Playing Screen, with Options to play (H/H, H/PC, PC/H, PC/PC)

print_play_menu:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                    PLAY                    |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|           1 - Player vs Player             |'), nl,
    print('|           2 - Player vs BOT                |'), nl,
    print('|           3 - BOT vs BOT                   |'), nl,
    print('|           4 - BOT vs Player                |'), nl,
    print('|           5 - Back                         |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl,
    print('                                              '), nl.
                  

play_option(1) :- start_game(1).                % Will take the Player to a New Game that's Player against Player
play_option(2) :- start_game_2(1).              % Will take the Player to a New Game that's Player against Bot
play_option(3) :- start_game_3(1).              % Will take the Player to a New Game that's Bot agains Bot
play_option(4) :- start_game_4(1).              % Will take the Player to a New Game that's Bot against Player
play_option(5) :- play.                         % Will take the Player back to the Starting Screen


% =============================================================== %

% Displays the Bot Menu, with the option to choose between Level 1 or Level 2 Bot, varying in difficulty


print_bot_menu:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                     BOT                    |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|               1 - Level 1                  |'), nl,
    print('|               2 - Level 2                  |'), nl,
    print('|               4 - Back                     |'), nl,
    print('|                                            |'), nl,
    print('|____________________________________________|'), nl,
    print('                                              '), nl.


ai_option(1) :- start_game(1).                          % Will take the Player to a New Game that's against a Level 1 Bot
ai_option(2) :- start_game(2).                          % Will take the Player to a New Game that's against a Level 2 Bot
ai_option(4) :- play_menu.                              % Will take the Player back to the Playing Menu


% =============================================================== %

% Displays the How to Play Screen, Teaching the Player the Rules of TRAXIT


print_how_to_play:-
    nl,nl,nl,
    print(' ============================================ '), nl,
    print('|                 HOW TO PLAY                |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|  Each player has 2 pawns and 16 path tiles |'), nl,
    print('|                                            |'), nl,
    print('|  Each of the 12 path tiles are unique      |'), nl,
    print('|                                            |'), nl,
    print('|  Chose a path tile that, after use, is     |'), nl,
    print('| discarded                                  |'), nl,
    print('|                                            |'), nl,
    print('|  You cant move through other pawns, nor    |'), nl,
    print('| outside the board, and if you cant move    |'), nl,
    print('| at all, your pawn is moved to the lowest   |'), nl,
    print('| level corner                               |'), nl,
    print('|                                            |'), nl,
    print('|                                            |'), nl,
    print('|                                            |'), nl,
    print('|         1 - Play          3 - Exit         |'), nl,
    print('|____________________________________________|'), nl,
    print('                                              '), nl,


    read(Input),                                %  Reads the user Input, that being either 1 or 2         
    menu_option(Input).                         %  If the user Inputs the number 1, they'll be redirected to Play Menu. If the Input is 3, this sends the User to the Exit Screen      
                                                            
% =============================================================== %

% Displays the Exit Screen


print_exit:-                                                 
    nl,nl,nl,                                                                           
    print(' ============================================ '), nl,
    print('|                    EXIT                    |'), nl,
    print('|============================================|'), nl,
    print('|                                            |'), nl,
    print('|             HOPE YOU HAD FUN!              |'), nl,
    print('|                                            |'), nl,
    print('|                  Goodbye!                  |'), nl,
    print('|____________________________________________|'), nl,
    print('                                              '), nl,

    sleep(2),                       % Waits a couple of seconds, so the User can read the Exit Screen, and then leaves
    halt.                           % Terminates the Prolog Execution

    
% =============================================================== %

% Instruction that Properly Initiates the Game, Printing the Starting Screen and Asking for an Input from the User
play :-
    print_menu,
    read(Input),
    menu_option(Input).

% Instruction that handles the Playing Menu, Printing it, and dealing with the User Input
play_menu :-
    print_play_menu,
    read(Input),
    play_option(Input).


% Instruction that handles the Bot Menu, Printing it, and dealing with the User Input
bot_menu :-
    print_bot_menu,
    read(Input),
    ai_option(Input).


% Instruction that makes the Bot Menu Pop Up
start_game_4(1) :-
    bot_menu.


