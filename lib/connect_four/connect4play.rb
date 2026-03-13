# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    include Connect4Game::C4Constants

    attr_accessor :connect4_board, :renderer, :gameover, :nextstates

    def initialize(name: 'Connect4',
                   players: nil, reloader: false)
      super(game_name: name, players: players, reloader: reloader)
      @new_tokens_per_turn = C4_NEW_TOKENS_PER_TURN unless reloader
      @token_moves_per_turn = C4_TOKEN_MOVES_PER_TURN unless reloader
      @connect4_board = Connect4Game::C4GameBoard.new unless reloader
      @renderer = Connect4Game::C4Renderer.new(board: connect4_board)
      @gameover = Connect4Game::C4GameOver.new(board: connect4_board)
      @nextstates = Connect4Game::C4NextStates.new(board: connect4_board)
      @placetokens = C4PlaceTokens.new(node_manager: node_manager,
                                       nextstates: nextstates,
                                       gameover: gameover,
                                       board: connect4_board)
    end

    def setup_new_game
      playersetup = C4PlayerSetup.new(gameover: gameover,
                                      board: connect4_board)
      self.players = playersetup.run_player_setup
    end

    def restore_state
      initialize(reloader: true)
      players.each do |player|
        player.restore_state(gameover: gameover,
                             board: connect4_board,
                             input: nil)
      end
    end

    def game_winner
      puts "#{gameover.winner(players: players)} wins!"
    end

    def tie_game
      puts 'Tie game.'
    end

    def add_new_player_tokens(player:)
      Array.new(@new_tokens_per_turn) do
        Token.new(
          token_name: 'stone',
          player_id: player.id,
          icon: player.icon,
          desc: 'game piece',
          cur_state: Connect4TokenState.new
        )
      end
    end

    def view_replay(on_state_change: nil, flush_display: nil)
      puts node_manager.all_nodes.inspect
      connect4_board.clear_board
      node_manager.played_tokens.each do |token|
        sleep 0.5
        connect4_board.update_board(token)
        clear(flush_display: flush_display)
        on_state_change&.call(render_gamestate)
        puts 'Replay'
      end
      puts game_winner
    end

    def render_gamestate
      renderer.return_board_with_borders
    end
  end
end
