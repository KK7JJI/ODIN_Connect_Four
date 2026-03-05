# frozen_string_literal: true

module Connect4Game
  # handles change of token state (i.e. movement)
  #
  class MoveTokens
    include Connect4Game::Constants
    include Connect4Game::SaveGame

    attr_accessor :node_manager, :gameover, :nextstates, :token_moves_per_turn

    def initialize(node_manager: nil, nextstates: nil, gameover: nil)
      @node_manager = node_manager
      @nextstates = nextstates
      @gameover = gameover
      @token_moves_per_turn = BASE_TOKEN_MOVES_PER_TURN
    end

    def move_player_tokens(player:)
      token_moves_per_turn.times do
        player_token_next_states(player)
        token = player.move_token
        node_manager.add_node(token: token)
        break if gameover.game_over?
      end
    end

    def player_token_next_states(player)
      player.tokens.each do |token|
        token.next_states = nextstates.request_next_states(token)
      end
    end
  end
end
