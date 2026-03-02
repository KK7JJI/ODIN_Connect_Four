# frozen_string_literal: true

# connect 4 namespace
module Connect4Game
  # calculate possible positions

  # calculate next possibible states given the
  # current token information. Connect 4.
  class C4NextStates
    attr_accessor :connect4_board

    def initialize(board: nil)
      @connect4_board = board
    end

    def request_next_states(token)
      token.next_states = connect4_board.open_columns.map do |col|
        Connect4Game::Connect4TokenState.new(col: col)
      end
      token
    end
  end
end
