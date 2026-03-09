# frozen_string_literal: true

module Connect4Game
  # rules for matching 4 in a row
  # by row on the gameboard
  class DiagMatch
    attr_accessor :all_diag_coords, :gameboard

    def initialize
      @all_diag_coords = nil
      @gameboard = Array.new(6) { Array.new(7) { ' ' } }
      @all_diag_coords = calc_all_diag_coords
    end

    def match?(gameboard: nil, num: 4)
      self.gameboard = gameboard
      diag_lines_xorepr = map_game_tokens_to_diagonals
      diag_lines_xorepr = serialize_lines(diag_lines_xorepr)
      regex = /X{#{num}}|O{#{num}}/

      diag_lines_xorepr.each do |xo_line|
        return true if xo_line.match?(regex)
      end

      false
    end

    def diag_lines(gameboard: nil)
      self.gameboard = gameboard
      diag_lines = map_game_tokens_to_diagonals
      serialize_lines(diag_lines)
    end

    def match(gameboard: nil, num: 4)
      regex = /X{#{num}}|O{#{num}}/
      diag_lines(gameboard: gameboard).each do |line|
        return line.match(regex).to_s if line.match?(regex)
      end

      nil
    end

    def match_count(gameboard: nil, num: 4)
      self.gameboard = gameboard
      regex = /X{#{num}}|O{#{num}}/
      count = 0
      diag_lines(gameboard: gameboard).each do |line|
        count += line.scan(regex).length
      end

      count
    end

    def map_game_tokens_to_diagonals
      diag_lines = []
      all_diag_coords.each do |diag_coords|
        line = []
        diag_coords.each do |x, y|
          line << gameboard[x][y]
        end
        diag_lines << line
      end
      diag_lines
    end

    def serialize_lines(lines)
      results = []
      lines.each do |line|
        results << line.join('')
      end
      results
    end

    def calc_all_diag_coords
      # produce an array of arrays describing diag_coords
      # on the game board having a length of at least 4.
      arr = []
      rows = gameboard.length
      cols = gameboard[0].length
      (0...cols).each do |i|
        arr << calc_diag_coordinates([0, i], [1, 1])
        arr << calc_diag_coordinates([(rows - 1), i], [-1, -1])
        arr << calc_diag_coordinates([0, i], [1, -1])
        arr << calc_diag_coordinates([(rows - 1), i], [-1, 1])
      end

      (0...rows).each do |i|
        arr << calc_diag_coordinates([i, 0], [1, 1])
        arr << calc_diag_coordinates([i, (cols - 1)], [-1, -1])
        arr << calc_diag_coordinates([i, (cols - 1)], [1, -1])
        arr << calc_diag_coordinates([i, 0], [-1, 1])
      end

      # arr.select { |row| row.length > 3 }
      arr = permutations_of_four(arr)
    end

    def calc_diag_coordinates(pos, dir)
      # called recursively to produce an array of row, col
      # coordinates on a diagonal.
      rows = gameboard.length
      cols = gameboard[0].length
      return [pos] if pos[0] == 0 && dir[0] < 0
      return [pos] if pos[1] == 0 && dir[1] < 0
      return [pos] if pos[0] == (rows - 1) && dir[0] > 0
      return [pos] if pos[1] == (cols - 1) && dir[1] > 0

      arr = calc_diag_coordinates(pos.zip(dir).map { |a, b| a + b }, dir)
      arr << pos
    end

    def permutations_of_four(diag_lines)
      results = []
      diag_lines.each do |line|
        until line.length < 4
          results << line.slice(0...4)
          line.shift
        end
      end
      results
    end
  end
end
