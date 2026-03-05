# frozen_string_literal: true

module Connect4Game
  # computer supplies random results
  class Random < Player
    include Connect4Game::SaveGame

    def place_token(token)
      token.cur_state = token.next_states.sample
      tokens << token
      token
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
