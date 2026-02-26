# frozen_string_literal: true

module Connect4Game
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
end
