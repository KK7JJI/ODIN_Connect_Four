# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    include Connect4Game::Constants
    attr_accessor :connect4_board, :token_count

    def initialize(name: 'Connect4', players: [])
      super(game_name: name, players: players)
      @connect4_board = Array.new(ROWS_COUNT) { [] }
      @new_tokens_per_turn = C4_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = C4_TOKEN_MOVES_PER_TURN
    end

    def reset_gamestate
      super
      self.connect4_board = Array.new(ROWS_COUNT) { [] }
    end

    def add_new_player_tokens(player, new_token_count)
      # player gets 1 new stone to place per turn
      new_token_count.times do |_i|
        token_state = Connect4TokenState.new
        new_player_tokens << Token.new(token_name: 'stone',
                                       owner: player,
                                       desc: game_piece,
                                       cur_state: token_state)
      end
    end

    def full?
      available_columns == []
    end

    def game_over?
      # to do: need to locate 4 in a row
      return true if full?

      false
    end

    def available_columns
      row_lens = connect4_board.map(&:length)
      (0...row_lens.length).to_a.select do |i|
        row_lens[i] < COLS_COUNT
      end
    end

    def next_states(token)
      arr = available_columns
      token.next_states = arr.map do |i|
        Connect4TokenState.new(row: i, col: connect4_board[i].length)
      end
    end

    def place_player_tokens(player)
      new_player_tokens.each do |token|
        print_gamestate
        next_states(token)
        token = player.place_token(token)
        update_board(token)
        break if game_over?
      end
    end

    def update_board(token)
      connect4_board[token.cur_state.row] << token
      self.token_count += 1
    end

    def print_gamestate
      puts render_gamestate_to_ascii
    end

    def render_gamestate_to_ascii
      Connect4Render.new(board: connect4_board, borders: true).ascii_state_rep
    end
  end
end
