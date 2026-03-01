# frozen_string_literal: true

module Connect4Game
  # node to track gameplay
  # representation of the connect 4 board used to
  # store current gamestate.
  class C4GameBoard
    include Constants

    attr_accessor :board, :renderer

    def initialize(renderer: nil)
      @board = Array.new(GAME_COLUMNS) { [] }
      @renderer = renderer
    end

    def open_columns
      row_lens = board.map(&:length)
      (0...row_lens.length).to_a.select do |i|
        row_lens[i] < GAME_ROWS
      end
    end

    def xo_array
      # call to c4asciirenderer
      raise NotImplementedError if renderer.nil?

      renderer.return_xo_array
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

    private

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
