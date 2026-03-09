# frozen_string_literal: true

module Connect4Game
  # rules for matching 4 in a row
  # by row on the gameboard
  class ColMatch
    def match?(gameboard: nil, num: 4)
      # transpose board
      # transpose is basically (x,y) -> (y,x)
      # gameboard_t = gameboard[0].length.times.map do |i|
      #   gameboard.map { |row| row[i] }
      # end
      # row_match?(gameboard_t)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match?(gameboard: gameboard_t, num: num)
    end

    def row_match?(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      gameboard.any? do |row|
        row.join('').match?(regex)
      end
    end

    def match(gameboard: nil, num: 4)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match(gameboard: gameboard_t, num: num)
    end

    def match_count(gameboard: nil, num: 4)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match_count(gameboard: gameboard_t, num: num)
    end

    def row_match(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      return nil unless row_match?(gameboard: gameboard, num: num)

      winning_row = gameboard.select do |row|
        row.join('').match?(regex)
      end
      winning_row.join('').match(regex).to_s
    end

    def row_match_count(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      count = 0

      gameboard.each do |row|
        count += row.join('').scan(regex).length
      end

      count
    end
  end
end
