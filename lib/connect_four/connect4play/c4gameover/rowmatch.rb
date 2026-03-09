# frozen_string_literal: true

module Connect4Game
  # rules for matching 4 in a row
  # by row on the gameboard
  class RowMatch
    def match?(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      gameboard.any? do |row|
        row.join('').match?(regex)
      end
    end

    def match(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      return nil unless match?(gameboard: gameboard, num: num)

      winning_row = gameboard.select do |row|
        row.join('').match?(regex)
      end
      winning_row.join('').match(regex).to_s
    end

    def match_count(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      count = 0

      gameboard.each do |row|
        count += row.join('').scan(regex).length
      end

      count
    end
  end
end
