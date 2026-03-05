# frozen_string_literal: true

module Connect4Game
  # rules for matching 4 in a row
  # by row on the gameboard
  class RowMatch
    def initialize
      @match = /X{4}|O{4}/
    end

    def match?(gameboard)
      gameboard.any? do |row|
        row.join('').match?(@match)
      end
    end

    def match(gameboard)
      return nil unless match?(gameboard)

      winning_row = gameboard.select do |row|
        row.join('').match?(@match)
      end
      winning_row.join('').match(@match).to_s
    end
  end
end
