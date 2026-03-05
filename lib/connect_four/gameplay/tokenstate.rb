# frozen_string_literal: true

module Connect4Game
  # describes the token's state (i.e. location) in the current game.
  class TokenState
    include Connect4Game::SaveGame

    def initialize(desc: '')
      @desc = desc
    end
  end
end
