# frozen_string_literal: true

module Connect4Game
  # end of game logic
  class GameOver
    include Connect4Game::SaveGame

    def game_over?
      raise NotImplementedError, 'game_over? not implemented for general game'
    end

    def winner?
      raise NotImplementedError, 'game_over? not implemented for general game'
    end

    def winner
      raise NotImplementedError, 'game_over not implemented for general game'
    end

    def draw?
      raise NotImplementedError, 'draw not implemeneted for general game'
    end
  end
end
