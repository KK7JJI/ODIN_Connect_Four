# frozen_string_literal: true

# connect 4 namespace
module Connect4Game
  # connect 4 constants
  module Constants
    # ROWS here = COLS in the connect 4 print out.
    # COLS here = ROWS in the connect 4 print out.
    CLS = "\e[2J\e[f" # puts CLS clears the screen.
    BASE_NEW_TOKENS_PER_TURN = 1
    BASE_TOKEN_MOVES_PER_TURN = 1
  end
end
