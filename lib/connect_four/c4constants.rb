# frozen_string_literal: true

# connect 4 namespace
module Connect4Game
  # connect 4 constants
  module C4Constants
    # ROWS here = COLS in the connect 4 print out.
    # COLS here = ROWS in the connect 4 print out.
    GAME_COLUMNS = 7
    GAME_ROWS = 6
    CENTER_COLUMN = 3

    C4_NEW_TOKENS_PER_TURN = 1
    C4_TOKEN_MOVES_PER_TURN = 0

    SCORE_POSITIONS = {
      win: [100, :player_icon], # game winning move
      bwin: [95, :opponent_icon], # block opponent's win
      dr3: [80, :player_icon], # create 3 in a row
      cr3: [70, :player_icon],
      rr3: [70, :player_icon],
      bdr3: [90, :opponent_icon], # attempt to block 3 in a row
      bcr3: [90, :opponent_icon],
      brr3: [90, :opponent_icon],
      dr2: [60, :player_icon], # create 2 in a row
      rr2: [60, :player_icon],
      cr2: [60, :player_icon],
      bdr2: [55, :opponent_icon], # attempt to block 2 in a row
      bcr2: [55, :opponent_icon],
      brr2: [55, :opponent_icon]
    }.freeze

    BOX_CHARS = {
      top_left_corner: "\u250c",
      top_right_corner: "\u2510",
      bot_left_corner: "\u2514",
      bot_right_corner: "\u2518",
      top_vertical_line: "\u252c",
      bot_vertical_line: "\u2534",
      left_horz_line: "\u251c",
      right_horz_line: "\u2524",
      vert_line: "\u2502",
      horz_line: "\u2500",
      cross: "\u253c"
    }.freeze
  end
end
