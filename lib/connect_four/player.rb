# frozen_string_literal: true

# connect 4 players
module Connect4
  # player parent class
  class Player
    attr_accessor :name, :connect4, :valid_next_positions

    COL_LENGTH = 7
    ROW_DEPTH = 6

    def initialize(name: 'Player', game: connect4)
      @name = name
      @connect4 = game
    end

    def valid_position?(val)
      val_int = val.to_i
      return false if val_int.to_s != val
      return false if val_int.negative?

      connect4.next_positions.include?(val_int)
    end
  end

  # human player
  class Human < Player
    def place_new_token
      val = 'a'
      until valid_position?(val)
        print 'Select next column: '
        val = $stdin.gets.chomp
      end
      val.to_i
    end
  end

  # computer supplies random results
  class Random < Player
    def place_new_token
      connect4.next_positions.sample
    end
  end
end
