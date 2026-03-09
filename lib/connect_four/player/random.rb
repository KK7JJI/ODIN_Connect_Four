# frozen_string_literal: true

module Connect4Game
  # computer supplies random results
  class Random < Player
    def place_token(token)
      puts 'Random Place Token'
      token.cur_state = token.next_states.sample
      tokens << token
      token
    end
  end
end
