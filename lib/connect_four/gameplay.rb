# frozen_string_literal: true

module Connect4
  # Coordination for the connect 4 game.
  class GamePlay
    attr_accessor :players

    PLAYER_HANDLER = {
      place_new_token: lambda(&:place_new_token)
    }

    def initialize
      @name = 'Connect 4 - SJH Edition'
      @players = []
    end

    def next_positions
      [0, 1, 2, 4, 5, 6]
    end

    def play_round
      until game_over?
        players.each do |player|
          col = PLAYER_HANDLER[:place_new_token].call(player)
        end
      end
    end
  end
end
