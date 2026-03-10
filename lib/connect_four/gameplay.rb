# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    include Connect4Game::Constants
    include Connect4Game::SaveGame

    attr_accessor :players, :node_manager, :nextstates, :gameover,
                  :placetokens, :movetokens

    def initialize(game_name: 'generic game',
                   players: nil, reloader: false)
      @game_name = game_name unless reloader
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN unless reloader
      @token_moves_per_turn = BASE_TOKEN_MOVES_PER_TURN unless reloader
      @my_turn = nil unless reloader
      @players = players || [] unless reloader
      @node_manager = NodeManager.new unless reloader
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
      if players.empty?
        setup_new_game
      else
        restore_state
      end

      catch(:savegame) do
        until gameover.game_over?
          players.each do |player|
            @my_turn = player.id if @my_turn.nil?
            next if @my_turn != player.id

            player_turn(player: player,
                        on_state_change: on_state_change,
                        flush_display: flush_display)
            break if gameover.game_over?

            @my_turn = nil
          end
        end
      end

      game_ending(on_state_change: on_state_change,
                  flush_display: flush_display)

      return unless view_replay?

      view_replay(on_state_change: on_state_change,
                  flush_display: flush_display)
    end

    def game_ending(on_state_change: nil,
                    flush_display: nil)
      clear(flush_display: flush_display)
      on_state_change&.call(render_gamestate)

      if gameover.game_over?
        game_winner if gameover.winner?
        tie_game if gameover.draw?
      else # save game was triggered.
        save_game
      end
    end

    def view_replay(on_state_change: nil,
                    flush_display: nil)
      clear(flush_display: flush_display)
      on_state_change&.call(render_gamestate)
      node_manager.game_nodes.each do |node|
        puts node.id
      end
      puts game_winner
    end

    def view_replay?
      print 'View replay (Y or N): '
      ans = $stdin.getch.upcase
      until %w[Y N].include?(ans)
        print "\ntry again: "
        ans = $stdin.getch.upcase
      end

      return false if ans == 'N'

      true
    end

    def clear(flush_display: nil)
      flush_display&.call
    end

    def game_winner
      gameover.winner(player: players)
    end

    def tie_game
      gameover.draw
    end

    def player_turn(player:, on_state_change: nil, flush_display: nil)
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

    def restore_state
      initialize(reloader: true)
      players.each(&:restore_state)
    end

    def render_gamestate
      @renderer.render(node_manager.last_node)
    end

    def save_game
      puts 'Saving game .....'
      json_data = to_json
      fname = save_filename
      f = File.open("#{fname}.c4", 'w')
      f.puts json_data
      f.close

      puts 'Save complete, exiting.'
      exit
    end

    def save_filename
      print("\nEnter Filename: ")
      fname = $stdin.gets.chomp

      until valid_filename?(fname)
        puts 'Invalid filename, try again.'
        fname = $stdin.gets.chomp
      end
      fname
    end

    def valid_filename?(filename)
      return true if filename =~ /\A[A-Za-z][0-9A-Za-z._-]+\z/

      false
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
