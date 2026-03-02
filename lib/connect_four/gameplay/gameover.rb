# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class GameOver
    def game_over?
      raise NotImplementedError, 'game_over? not implemented for general game'
    end
  end
end
