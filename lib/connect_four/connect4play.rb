# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    include Connect4Game::Constants
    attr_accessor :connect4_board, :renderer, :gameover

    def initialize(name: 'Connect4',
                   players: nil,
                   renderer: C4Renderer.new)
      super(game_name: name, players: players, renderer: renderer)
      @renderer = renderer
      @gameover = Connect4Game::GameOver.new
      @connect4_board = Connect4Game::C4GameBoard.new(renderer: renderer)
      @renderer.connect4_board = @connect4_board
      @gameover.connect4_board = @connect4_board

      @new_tokens_per_turn = C4_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = C4_TOKEN_MOVES_PER_TURN
    end

    def add_new_player_tokens(player:)
      Array.new(@new_tokens_per_turn) do
        Token.new(
          token_name: 'stone',
          owner: player,
          desc: 'game piece',
          cur_state: Connect4TokenState.new
        )
      end
    end

    def place_token(player:, token:)
      token = player.place_token(token)
      connect4_board.update_board(token)
    end

    def game_over?
      return true if gameover.draw?
      return true if gameover.winner?

      false
    end

    def compute_next_states(token)
      token.next_states = connect4_board.open_columns.map do |col|
        Connect4Game::Connect4TokenState.new(col: col)
      end
      token
    end

    def render_gamestate
      renderer.return_board_with_borders
    end
  end
end
