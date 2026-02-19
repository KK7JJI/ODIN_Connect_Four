# frozen_string_literal: true

GAME_ROWS = 6
GAME_COLS = 7
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

module ConnectFour
  # routines to print current game state
  module GameDisplay
    module_function

    def print_game(arr)
      arr = transpose(arr)
      disp = []
      top_border = top_border(GAME_COLS)
      middle_divider = middle_divider(GAME_COLS)
      bottom_border = bottom_border(GAME_COLS)

      disp << top_border

      arr.map do |row|
        disp << middle_values(row)
        disp << middle_divider
      end

      disp[-1] = bottom_border
      puts disp.join("\n")
    end

    def transpose(arr, fill: ' ')
      # arr rows are game columns,
      # row[0] is at the bottom of the board.
      max_len = arr.reduce(0) { |a, elem| [a, elem.length].max }
      (max_len.times.map do |i|
        arr.map { |row| row[i] || fill }
      end).reverse
    end

    def top_border(n)
      result = String.new(BOX_CHARS[:top_left_corner])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:top_vertical_line] + BOX_CHARS[:horz_line]) * (n - 1)
      result << BOX_CHARS[:top_right_corner]
      result
    end

    def middle_values(arr)
      result = String.new(BOX_CHARS[:vert_line])
      result << arr.join(BOX_CHARS[:vert_line])
      result << BOX_CHARS[:vert_line]
      result
    end

    def middle_divider(n)
      result = String.new(BOX_CHARS[:left_horz_line])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:cross] + BOX_CHARS[:horz_line]) * (n - 1)
      result << BOX_CHARS[:right_horz_line]
      result
    end

    def bottom_border(n)
      result = String.new(BOX_CHARS[:bot_left_corner])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:bot_vertical_line] + BOX_CHARS[:horz_line]) * (n - 1)
      result << BOX_CHARS[:bot_right_corner]
      result
    end
  end
end
