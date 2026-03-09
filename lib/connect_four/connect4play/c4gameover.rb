# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class C4GameOver
    include Connect4Game::Constants
    include Connect4Game::C4Constants

    attr_accessor :connect4_board, :row_matching, :col_matching,
                  :diag_matching

    def initialize(row_match: RowMatch.new,
                   col_match: ColMatch.new,
                   diag_match: DiagMatch.new,
                   board: nil)
      @connect4_board = board
      @row_matching = row_match
      @col_matching = col_match
      @diag_matching = diag_match
    end

    def winner?
      gameboard = connect4_board.xo_array
      return true if row_match?(gameboard: gameboard, num: 4)
      return true if column_match?(gameboard: gameboard, num: 4)
      return true if diagonal_match?(gameboard: gameboard, num: 4)

      false
    end

    def winner(players:)
      return nil unless winner?

      gameboard = connect4_board.xo_array
      match_str = row_match(gameboard: gameboard) if row_match?(gameboard: gameboard, num: 4)
      match_str = column_match(gameboard: gameboard) if column_match?(gameboard: gameboard, num: 4)
      match_str = diagonal_match(gameboard: gameboard) if diagonal_match?(gameboard: gameboard, num: 4)
      players.each do |player|
        return player.name if player.icon == match_str.slice(0)
      end
    end

    def game_over?(*)
      return true if draw?
      return true if winner?

      false
    end

    def draw?
      return true if connect4_board.full?

      false
    end

    def row_match?(gameboard: nil, num: 4)
      row_matching.match?(gameboard: gameboard, num: num)
    end

    def row_match(gameboard: nil, num: 4)
      row_matching.match(gameboard: gameboard, num: num)
    end

    def column_match?(gameboard: nil, num: 4)
      col_matching.match?(gameboard: gameboard, num: num)
    end

    def column_match(gameboard: nil, num: 4)
      col_matching.match(gameboard: gameboard, num: num)
    end

    def diagonal_match?(gameboard: nil, num: 4)
      diag_matching.match?(gameboard: gameboard, num: num)
    end

    def diagonal_match(gameboard: nil, num: 4)
      diag_matching.match(gameboard: gameboard, num: num)
    end

    def row_match_count(gameboard: nil, num: 4)
      row_matching.match_count(gameboard: gameboard, num: num)
    end

    def col_match_count(gameboard: nil, num: 4)
      col_matching.match_count(gameboard: gameboard, num: num)
    end

    def diag_match_count(gameboard: nil, num: 4)
      diag_matching.match_count(gameboard: gameboard, num: num)
    end
  end
end
