# frozen_string_literal: true

# namespace for connect 4 game
module Connect4Game
  # store current state of the game.
  class Connect4play < GamePlay
    attr_accessor :connect4_board, :token_count

    # ROWS here = COLS in the connect 4 print out.
    # COLS here = ROWS in the connect 4 print out.
    ROWS_COUNT = 7
    COLS_COUNT = 6
    NEW_TOKENS_PER_TURN = 1
    TOKEN_MOVES_PER_TURN = 0

    def initialize(name: 'Connect4')
      super(game_name: name)
      @connect4_board = Array.new(ROWS_COUNT) { [] }
    end

    def reset_gamestate
      super
      self.connect4_board = Array.new(ROWS_COUNT) { [] }
    end

    def add_new_player_tokens
      # player gets 1 new stone to place per turn
      NEW_TOKENS_PER_TURN.times do |_i|
        token_state = Connect4TokenState.new
        new_token = Token.new(owner: player, cur_state: token_state)
        new_player_tokens << new_token
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
  end

  # player token locations
  class Connect4TokenState < TokenState
    attr_accessor :id
    attr_reader :row, :col

    def initialize(row: -1, col: -1)
      super(desc: '')
      # token location information
      @row = row
      @col = col
      @id = [row, col].inspect
    end

    def row=(value)
      @row = value
      @id = [value, @col].inspect
    end

    def col=(value)
      @col = value
      @id = [@row, value].inspect
    end
  end
end
