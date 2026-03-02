# frozen_string_literal: true

# basic Nextstates used for testing gameplay logic
# override needed when modeling game.
module Connect4Game
  # calculate possible positions
  class NextStates
    def request_next_states(token)
      token.next_states = []
      token
    end
  end
end
