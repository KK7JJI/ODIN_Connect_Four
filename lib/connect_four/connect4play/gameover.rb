# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class GameOver
    include Constants
    attr_accessor :win, :all_diag_coords, :gameboard

    def initialize(board: xo_array)
      @win = /X{4}|O{4}/
      @gameboard = board
      @all_diag_coords = calc_all_diag_coords
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
      gameboard.any? do |row|
        row.join('').match?(win)
      end
    end

    def column_match?(gameboard)
      # transpose board
      # transpose is basically (x,y) -> (y,x)
      gameboard_t = gameboard[0].length.times.map do |i|
        gameboard.map { |row| row[i] }
      end
      row_match?(gameboard_t)
    end

    def diagonal_match?(gameboard)
      diag_lines = map_game_tokens_to_diagonals(gameboard)
      diag_lines = serialize_lines(diag_lines)
      diag_lines.each do |line|
        return true if line.match?(win)
      end

      false
    end

    def map_game_tokens_to_diagonals(gameboard)
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

    def full?
      gameboard.flatten.none? { |elem| elem == ' ' }
    end

    def empty?
      gameboard.flatten.all? { |elem| elem == ' ' }
    end
  end
end
