# ODIN_Ruby_Connect4
TOP ODIN Ruby Connect 4 game project.

## Prerequisits
The application is written in bash (run.sh) and ruby.  The application was
developed and tested as an exercise following The Odin Project's Ruby on Rails
curriculum on a linux computer using:

- Ruby version 3.4.6.
- GNU Bash version 5.2.21(1)

[Project Connect 4](https://www.theodinproject.com/lessons/ruby-connect-four)

## Installation
Clone this respository to your local filesystem and make the file `./bin/run.sh`
executible:
```
cd ./bin
chmod +x ./run.sh
```

## Playing Connect 4
### Startup
The game is run from the command line interface.

examples
```
./bin/run.sh      # start a new game
```
### Player Setup
At the start of a new game player setup is required.  This is a two player game 
where each player may either be a human player (opt. 1) or a computer player (opt. 2).
It is possible to configure both players as computer players.

Player names are requested but are optional.

```
$ ./run.sh
File: connect_four.rb, Running method: run
Player name (default Player 1)
Player 1 is 1. a human player or 2. a computer player:
enter 1 or 2: 1
Player name (default Player 2)
Player 2 is 1. a human player or 2. a computer player:
enter 1 or 2: 1
```

### Gameplay
With each round each player selects one of 7 columns numbered 0 - 6 in which to
place a token (player 1 = 'X', player 2 = 'O').  That token will then occupy the 
lowest unoccupied row in the selected column.  Each column holds up to 6 tokens.

The games ends when:
- The board is full (draw)
- Either player strings 4 tokens in a line on any of the board's:
    - rows
    - columns, or
    - diagonals

The first player to get 4 in a row wins the game.

```
┌─┬─┬─┬─┬─┬─┬─┐
│ │X│O│X│O│ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │O│O│X│X│O│ │
├─┼─┼─┼─┼─┼─┼─┤
│ │X│X│O│O│X│ │
├─┼─┼─┼─┼─┼─┼─┤
│ │O│O│X│X│O│X│
├─┼─┼─┼─┼─┼─┼─┤
│ │O│X│X│O│X│O│
├─┼─┼─┼─┼─┼─┼─┤
│X│O│O│X│X│O│X│
└─┴─┴─┴─┴─┴─┴─┘
Player 1 wins!

```
At the end of the game an instant replay may be optionally initiated.  This can
be helpful in watching computer v computer games play out.

```
Player 1 wins!
View replay (Y or N):
```

[Wikipedia: Connect 4](https://en.wikipedia.org/wiki/Connect_Four)

### Save game

On a human player's turn the player may opt to save and end the game by entering
'S' instead of a column number.

```
┌─┬─┬─┬─┬─┬─┬─┐
│ │ │ │ │ │ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │ │ │ │ │ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │ │ │ │ │ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │ │ │ │ │ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │ │ │O│ │ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │ │X│X│ │ │ │
└─┴─┴─┴─┴─┴─┴─┘
Saving game .....

Enter Filename: save
```

The next time the game is started an option is given to reload the saved game
or to start a new game.

```
File: connect_four.rb, Running method: run
Saved games
----------------------------
1, save.c4
----------------------------
Select file (press enter for new game):
```

### Notes on Computer Play

The computer player in this game employs a very basic scoring system that
looks only 1 move ahead.  It represents a fairly simple improvement over random
placement of tokens.  The computer player will select moves in the following
order:

1) Always select the game winning move.
2) Block the opponent's winning opportunity.
3) Create 3 in a row on the diagonal.
4) Create 3 in a row on a column or row.
5) Block the opponent's 3 in a row opportunity on a diagonal.
6) Block the opponent's 3 in a row opportunity on a column or row.
7) Create 2 in a row on the diagonal.
8) Create 2 in a row on a column or row.
9) Block the opponent's 2 in a row opportunity on a diagonal.
10) Block the opponent's 2 in a row opportunity on a column or row.

In cases where there are multiple moves which achieve the same goal the move
closest to the center will be selected first.

In cases were token placement configuation scores are tied a move is chosen
at random from the highest scoring options.  

Beating this model is done by placing
tokens so that a chain of 3 in a row can't be blocked in a single move and then
waiting for the computer player to niavely place the token which allows the 
winning token to be played.

Example: Once the computer player, player 2, places an 'O' on column 6 
player 1 follows by placing an 'X' on column 6 for the win (recall that column numbers 
start with '0').  The computer player's algorithm cannot detect the fault in selecting that 
move without looking 2 moves ahead.
```
┌─┬─┬─┬─┬─┬─┬─┐
│ │X│O│X│O│ │ │
├─┼─┼─┼─┼─┼─┼─┤
│ │O│O│X│X│O│ │
├─┼─┼─┼─┼─┼─┼─┤
│ │X│X│O│O│X│ │
├─┼─┼─┼─┼─┼─┼─┤
│ │O│O│X│X│O│ │
├─┼─┼─┼─┼─┼─┼─┤
│ │O│X│X│O│X│ │
├─┼─┼─┼─┼─┼─┼─┤
│X│O│O│X│X│O│X│
└─┴─┴─┴─┴─┴─┴─┘
```


