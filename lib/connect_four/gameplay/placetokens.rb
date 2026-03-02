# frozen_string_literal: true

module Connect4Game
  include Constants

  # Coordination for the connect 4 game.
  class PlaceTokens
    attr_accessor :node_manager, :new_tokens_per_turn, :nextstates

    def initialize(node_manager: nil, nextstates: nil)
      @node_manager = node_manager
      @nextstates = nextstates
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
    end

    def place_new_tokens(player:)
      new_player_tokens = new_player_tokens(player: player)
      while new_player_tokens.length.positive?
        token = new_player_tokens.shift
        nextstates.request_next_states(token)
        token = place_token(player: player, token: token)
        node_manager.add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def new_player_tokens(player:)
      Array.new(@new_tokens_per_turn) do
        Token.new(token_name: 'stone', owner: player, desc: 'game piece')
      end
    end

    def place_token(player:, token:)
      player.place_token(token)
    end
  end
end
