# frozen_string_literal: true

# connect4 namespace
module Connect4Game
  # describes the token's state (i.e. location) in the current game.
  include Connect4Game::SaveGame

  # describes the state of this token in the game.
  class TokenState
    def initialize(desc: '')
      @desc = desc
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
