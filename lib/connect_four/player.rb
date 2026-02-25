# frozen_string_literal: true

# connect 4 players
module Connect4Game
  # player parent class
  class Player
    attr_accessor :name, :connect4, :next_states, :tokens, :icon, :input

    def initialize(name: 'Player', icon: '', desc: '',
                   input: UserInput.new)
      @name = name
      @desc = desc
      @icon = icon
      @input = input

      @next_states = []
      @tokens = []
    end

    def valid_selection?(val)
      val_int = val.to_i
      return false if val_int.to_s != val
      return false if val_int.negative?

      next_states.include?(val_int)
    end

    def move_token
      true
    end
  end

  # human player
  class Human < Player
    def place_token(token)
      # player accepts an object with obj.next_states
      self.next_states = token.next_states.map(&:col)
      selection = next_states.index(user_input)
      token.cur_state = token.next_states[selection]
      tokens << token
      token
    end

    def user_input
      val = 'a'
      until valid_selection?(val)
        print 'Select column: '
        val = input.get
      end
      val.to_i
    end
  end

  # computer supplies random results
  class Random < Player
    def place_token(token)
      token.cur_state = token.next_states.sample
      tokens << token
      token
    end
  end

  # define user input method
  class UserInput
    def get
      $stdin.gets.chomp
    end
  end
end
