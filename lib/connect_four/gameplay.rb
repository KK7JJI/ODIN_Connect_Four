# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    include Connect4Game::Constants
    attr_accessor :players, :node_manager, :nextstates, :gameover,
                  :placetokens, :movetokens

    def initialize(game_name: 'generic game',
                   players: nil)
      @game_name = game_name
      @players = players || []
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = BASE_TOKEN_MOVES_PER_TURN

      @node_manager = NodeManager.new
      @renderer = SimplerAsciiRenderer.new
      @gameover = GameOver.new
      @nextstates = NextStates.new
      @placetokens = PlaceTokens.new(node_manager: node_manager,
                                     nextstates: nextstates,
                                     gameover: gameover)
      @movetokens = MoveTokens.new(node_manager: node_manager,
                                   nextstates: nextstates,
                                   gameover: gameover)
    end

    def play_round(on_state_change: nil)
      setup_new_game
      on_state_change&.call(render_gamestate)
      until gameover.game_over?
        players.each do |player|
          player_turn(player: player)
          break if gameover.game_over?

          on_state_change&.call(render_gamestate)
        end
      end
      on_state_change&.call(render_gamestate)
    end

    def player_turn(player:)
      puts player.name
      placetokens.place_new_tokens(player: player) if !gameover.game_over? && supports_new_tokens?
      movetokens.move_player_tokens(player: player) if !gameover.game_over? && supports_token_movement?
    end

    def supports_new_tokens?
      @new_tokens_per_turn.positive?
    end

    def supports_token_movement?
      @token_moves_per_turn.positive?
    end

    def setup_new_game
      self.players = PlayerSetup.new.run_player_setup
    end

    def render_gamestate
      @renderer.render(node_manager.last_node)
    end
  end
end
