# frozen_string_literal: true

module Connect4Game
  # computer supplies supplies results based on
  # a scoring system.  Moves are favored as follows:

  # win game
  # block opponent win
  # 3 - row diagonal
  # 3 - row column or row
  # block opponent 3 in a row
  # 2 - row diagonal
  # 2 - row column or row
  # Closest to center

  # moves with the same score
  # are chosen at random

  class G1 < Player
    def place_token(token)
      token.cur_state = token.next_states.sample
      tokens << token
      token
    end
  end
end
