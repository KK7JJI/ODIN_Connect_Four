# frozen_string_literal: true

# connect 4 players
module Connect4Game
  # player parent class
  class Player
    include Connect4Game::SaveGame

    attr_accessor :name, :connect4, :next_states, :tokens, :icon, :input, :id

    def initialize(name: 'Player', icon: '', desc: '', id: nil,
                   input: UserInput.new)
      @name = name
      @desc = desc
      @icon = icon
      @input = input
      @next_states = []
      @tokens = []
      @id = id
    end

    def reinitialize(input: UserInput.new)
      @input = input
    end

    def valid_selection?(val)
      val_int = val.to_i
      return false if val_int.to_s != val
      return false if val_int.negative?

      next_states.include?(val_int)
    end

    def place_token
      raise NotImplementedError, 'Player, place_token requires player/game specific subclass'
    end

    def move_token
      raise NotImplementedError, 'Player, move_token requires player/game specific subclass'
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
