# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class GameOver
    include Constants
    attr_accessor :win, :all_diag_coords, :gameboard,
                  :row_match, :col_match, :diag_match

    def initialize(board: xo_array,
                   row_match: RowMatch.new,
                   col_match: ColMatch.new,
                   diag_match: DiagMatch.new)
      @win = /X{4}|O{4}/
      @gameboard = board
      @row_match = row_match
      @col_match = col_match
      @diag_match = diag_match
    end

    def winner?
      # gameboard.each do |row|
      #   puts row.inspect
      # end
      return true if row_match?(gameboard)
      return true if column_match?(gameboard)
      return true if diagonal_match?(gameboard)

      false
    end

    def draw?
      return true if full?

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

    def full?
      gameboard.flatten.none? { |elem| elem == ' ' }
    end

    def empty?
      gameboard.flatten.all? { |elem| elem == ' ' }
    end
  end
end
