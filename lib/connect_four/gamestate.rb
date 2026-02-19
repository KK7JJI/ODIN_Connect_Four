# frozen_string_literal: true

module Connect4
  # store current state of the game.
  class Gamestate
    attr_accessor :connect4_board, :token_count

    COL_LENGTH = 7
    ROW_DEPTH = 6

    def initialize
      @connect4_board = Array.new(COL_LENGTH) { [] }
      @token_count = 0
    end

    def drop_token_on_col(n, token)
      connect4_board[n].push(token)
      token.row = n
      token.col = connect4_board[n].length - 1
      self.token_count += 1
    end

    def next_positions
      row_lens = connect4_board.map(&:length)
      (0...row_lens.length).to_a.select do |i|
        row_lens[i] < ROW_DEPTH
      end
    end

    def full?
      next_positions == []
    end
  end

  # player token locations
  class Token
    attr_accessor :value, :id
    attr_reader :row, :col

    def initialize(row: 0, col: 0, value: ' ')
      # note, for connect 4, rows will be displayed as columns
      # in order to visualize dropping tokens into place.
      @row = row
      @col = col
      @value = value
      @id = [row, col].inspect
    end

    def row=(value)
      @row = value
      @id = [value, @col].inspect
    end

    def col=(value)
      @col = value
      @id = [@row, value].inspect
    end
  end
end
