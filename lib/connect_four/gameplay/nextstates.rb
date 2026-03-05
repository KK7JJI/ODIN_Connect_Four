# frozen_string_literal: true

# basic Nextstates used for testing gameplay logic
# override needed when modeling game.
module Connect4Game
  # calculate possible positions
  class NextStates
    include Connect4Game::SaveGame
    include Connect4Game::SaveGame

    def request_next_states(token)
      token.next_states = []
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
