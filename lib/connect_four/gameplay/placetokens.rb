# frozen_string_literal: true

module Connect4Game
  include Constants

  # Coordination for the connect 4 game.
  class PlaceTokens
    include Connect4Game::Constants
    attr_accessor :node_manager, :new_tokens_per_turn, :nextstates,
                  :gameover

    def initialize(node_manager: nil, nextstates: nil, gameover: nil)
      @node_manager = node_manager
      @nextstates = nextstates
      @gameover = gameover
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
    end

    def place_new_tokens(player:)
      new_player_tokens = new_player_tokens(player: player)
      while new_player_tokens.length.positive?
        token = new_player_tokens.shift
        token.next_states = nextstates.request_next_states(token)
        token = place_token(player: player, token: token)
        node_manager.add_node(token: token)
        break if gameover.game_over?
      end
    end

    def new_player_tokens(player:)
      Array.new(new_tokens_per_turn) do
        Token.new(token_name: 'stone',
                  owner: player,
                  desc: 'game piece',
                  cur_state: TokenState.new)
      end
    end

    def place_token(player:, token:)
      player.place_token(token)
    end
  end
end
