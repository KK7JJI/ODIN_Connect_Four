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
./bin/run.sh            #start the game with a default of 10 guesses
```
### Player Setup
At the start of a new game player setup is required.  This is a two player where
each player may either be a human player (opt. 1) or a computer player (opt. 2).
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
With each round the player select one of 7 columns numbered 0 - 6 in which to
place a token (aka stone or checker).

The games ends when:
- The board is full (draw)
- Either player gets 4 tokens in a row on any of:
    - Rows
    - Columns
    - Diagonals

A player who gets 4 in a row wins the game.

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

[Wikipedia](https://en.wikipedia.org/wiki/Connect_Four)

### Save game

On a human player's turn the player may opt to save and end the game by entering
'S' instead of a column.

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
or start a new game.

```
File: connect_four.rb, Running method: run
Saved games
----------------------------
1, save.c4
----------------------------
Select file (press enter for new game):
```

### Computer Play

The computer player in this game employs a basic decision making scheme that
looks one move ahead.  The computer player will select moves in the following
order:

1) Game winning moved always.
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
at random from the high scoring options.

