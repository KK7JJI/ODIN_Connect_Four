# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    include Connect4Game::Constants
    include Connect4Game::SaveGame

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

    def play_round(on_state_change: nil, flush_display: nil)
      setup_new_game
      until gameover.game_over?
        players.each do |player|
          player_turn(player: player,
                      on_state_change: on_state_change,
                      flush_display: flush_display)
          break if gameover.game_over?
        end
      end
      clear(flush_display: flush_display)
      on_state_change&.call(render_gamestate)
      game_winner if gameover.winner?
      tie_game if gameover.draw?
    end

    def clear(flush_display: nil)
      flush_display&.call
    end

    def game_winner
      gameover.winner
    end

    def tie_game
      gameover.draw
    end

    def player_turn(player:, on_state_change: nil, flush_display: nil)
      puts player.name
      clear(flush_display: flush_display)
      on_state_change&.call(render_gamestate)
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

    def save_game
      json_data = to_json
      fname = player.save_filename
      f = File.open("#{fname}.hm", 'w')
      f.puts json_data
      f.close

      puts 'Save complete, exiting.'
      exit
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
