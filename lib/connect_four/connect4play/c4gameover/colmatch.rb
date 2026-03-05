# frozen_string_literal: true

module Connect4Game
  # rules for matching 4 in a row
  # by row on the gameboard
  class ColMatch
    def initialize
      @match = /X{4}|O{4}/
    end

    def match?(gameboard)
      # transpose board
      # transpose is basically (x,y) -> (y,x)
      # gameboard_t = gameboard[0].length.times.map do |i|
      #   gameboard.map { |row| row[i] }
      # end
      # row_match?(gameboard_t)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match?(gameboard_t)
    end

    def row_match?(gameboard)
      gameboard.any? do |row|
        row.join('').match?(@match)
      end
    end

    def match(gameboard)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match(gameboard_t)
    end

    def row_match(gameboard)
      return nil unless row_match?(gameboard)

      winning_row = gameboard.select do |row|
        row.join('').match?(@match)
      end
      winning_row.join('').match(@match).to_s
    end
  end
end
