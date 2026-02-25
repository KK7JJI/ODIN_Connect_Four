# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    include Connect4Game::Constants
    attr_accessor :connect4_board

    def initialize(name: 'Connect4', players: nil)
      super(game_name: name, players: players)
      @connect4_board = Array.new(GAME_COLUMNS) { [] }
      @new_tokens_per_turn = C4_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = C4_TOKEN_MOVES_PER_TURN
    end

    def reset_gamestate
      super
      self.connect4_board = Array.new(GAME_COLUMNS) { [] }
    end

    def add_new_player_tokens(player)
      Array.new(@new_tokens_per_turn) do
        Token.new(
          token_name: 'stone',
          owner: player,
          desc: 'game piece',
          cur_state: Connect4TokenState.new
        )
      end
    end

    def game_over?
      # to do: need to locate 4 in a row
      return true if full?

      false
    end

    def full?
      open_columns == []
    end

    def compute_next_states(token)
      token.next_states = open_positions
    end

    def open_positions
      open_columns.map do |i|
        Connect4TokenState.new(
          row: i,
          col: connect4_board[i].length
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
      connect4_board[token.cur_state.row] << token
    end

    def render_gamestate
      Connect4Render.new(board: connect4_board, borders: true).ascii_state_rep
    end
  end
end
