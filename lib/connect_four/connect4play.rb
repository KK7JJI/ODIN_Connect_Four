# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    include Connect4Game::Constants
    attr_accessor :connect4_board, :renderer, :gameover

    def initialize(name: 'Connect4',
                   players: nil,
                   renderer: C4Ascii4Renderer.new,
                   gameover: GameOver.new)
      super(game_name: name, players: players, renderer: renderer)
      @connect4_board = Array.new(GAME_COLUMNS) { [] }
      @new_tokens_per_turn = C4_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = C4_TOKEN_MOVES_PER_TURN
      @gameover = gameover
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
      update_board(token)
    end

    def game_over?
      return true if draw?
      return true if winner?

      false
    end

    def draw?
      gameover.draw?(renderer.return_xo_array(board: connect4_board))
    end

    def winner?
      gameover.winner?(renderer.return_xo_array(board: connect4_board))
    end

    def compute_next_states(token)
      token.next_states = open_positions
    end

    def open_positions
      open_columns.map do |i|
        Connect4TokenState.new(
          col: i,
          row: connect4_board[i].length
        )
      end
    end

    def open_columns
      row_lens = connect4_board.map(&:length)
      (0...row_lens.length).to_a.select do |i|
        row_lens[i] < GAME_ROWS
      end
    end

    def update_board(token)
      connect4_board[token.cur_state.col] << token
    end

    def render_gamestate
      renderer.render(board: connect4_board)
    end
  end
end
