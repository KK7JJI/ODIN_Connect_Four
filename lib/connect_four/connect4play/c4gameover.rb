# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class C4GameOver
    include Connect4Game::Constants
    include Connect4Game::SaveGame

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
      return true if row_match?(gameboard)
      return true if column_match?(gameboard)
      return true if diagonal_match?(gameboard)

      false
    end

    def winner(players:)
      return nil unless winner?

      gameboard = connect4_board.xo_array
      match_str = row_match(gameboard) if row_match?(gameboard)
      match_str = column_match(gameboard) if column_match?(gameboard)
      match_str = diagonal_match(gameboard) if diagonal_match?(gameboard)
      players.each do |player|
        return player.name if player.icon == match_str.slice(0)
      end
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
      row_matching.match?(gameboard)
    end

    def row_match(gameboard)
      row_matching.match(gameboard)
    end

    def column_match?(gameboard)
      col_matching.match?(gameboard)
    end

    def column_match(gameboard)
      col_matching.match(gameboard)
    end

    def diagonal_match?(gameboard)
      diag_matching.match?(gameboard)
    end

    def diagonal_match(gameboard)
      diag_matching.match(gameboard)
    end

    def full?(gameboard)
      gameboard.flatten.none? { |elem| elem == ' ' }
    end

    def empty?(gameboard)
      gameboard.flatten.all? { |elem| elem == ' ' }
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
