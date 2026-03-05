# frozen_string_literal: true

module Connect4Game
  # node to track gameplay
  # representation of the connect 4 board used to
  # store current gamestate.
  class C4GameBoard
    include Connect4Game::Constants
    include Connect4Game::SaveGame

    attr_accessor :board, :renderer

    def initialize
      @board = Array.new(GAME_COLUMNS) { [] }
    end

    def open_columns
      row_lens = board.map(&:length)
      (0...row_lens.length).to_a.select do |i|
        row_lens[i] < GAME_ROWS
      end
    end

    def xo_array
      # player 1: X, player 2: O
      transpose(board.map do |row|
        row.map { |token| token.icon }
      end)
    end

    def update_board(token)
      board[token.cur_state.col] << token
    end

    def full?
      board.none? { |row| row.length < GAME_ROWS }
    end

    def empty?
      board.all?(&:empty?)
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end

    private

    def transpose(arr, fill: ' ')
      (GAME_ROWS.times.map do |i|
        arr.map { |row| row[i] || fill }
      end).reverse
    end

    def open_positions
      open_columns.map do |i|
        Connect4TokenState.new(
          col: i,
          row: board[i].length
        )
      end
    end
  end
end
