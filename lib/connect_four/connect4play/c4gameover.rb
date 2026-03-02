# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class C4GameOver
    include Constants
    attr_accessor :connect4_board, :row_match, :col_match, :diag_match

    def initialize(row_match: RowMatch.new,
                   col_match: ColMatch.new,
                   diag_match: DiagMatch.new,
                   board: nil)
      @connect4_board = board
      @row_match = row_match
      @col_match = col_match
      @diag_match = diag_match
    end

    def winner?
      gameboard = connect4_board.xo_array
      return true if row_match?(gameboard)
      return true if column_match?(gameboard)
      return true if diagonal_match?(gameboard)

      false
    end

    def game_over?
      return true if draw?
      return true if winner?

      false
    end

    def draw?
      gameboard = connect4_board.xo_array
      return true if full?(gameboard)

      false
    end

    def row_match?(gameboard)
      row_match.match?(gameboard)
    end

    def column_match?(gameboard)
      col_match.match?(gameboard)
    end

    def diagonal_match?(gameboard)
      diag_match.match?(gameboard)
    end

    def full?(gameboard)
      gameboard.flatten.none? { |elem| elem == ' ' }
    end

    def empty?(gameboard)
      gameboard.flatten.all? { |elem| elem == ' ' }
    end
  end
end
