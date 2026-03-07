# frozen_string_literal: true

module Connect4Game
  # computer supplies random results
  class G1Computer < Player
    def place_token(token)
      token.cur_state = token.next_states.sample
      tokens << token
      token
    end
  end
end
