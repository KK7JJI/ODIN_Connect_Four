# frozen_string_literal: true

module Connect4Game
  # generate an ascii representation of the gamestate
  class Connect4Render
    include Connect4Game::Constants
    attr_accessor :connect4_board, :rendered_board, :rendered_board_nb,
                  :borders, :xo_array

    def initialize(board: nil, borders: true)
      @connect4_board = board
      @xo_array = []
      @rendered_board = ''
      @rendered_board_nb = ''
      @borders = borders
    end

    def ascii_state_rep
      return 'no data' if connect4_board.nil?

      self.xo_array = transpose(connect4_board)
      self.rendered_board_nb = xo_array.join("\n")
      disp = []

      top_border = top_border(GAME_COLUMNS)
      middle_divider = middle_divider(GAME_COLUMNS)
      bottom_border = bottom_border(GAME_COLUMNS)

      disp << top_border
      xo_array.map do |row|
        disp << middle_values(row)
        disp << middle_divider
      end

      disp[-1] = bottom_border
      self.rendered_board = disp.join("\n")

      return rendered_board_nb unless borders

      rendered_board
    end

    def icon(token)
      token.icon
    end

    def transpose(arr, fill: ' ')
      # arr rows are game columns,
      # row[0] is at the bottom of the board.
      arr1 = arr.map do |row|
        row.map { |token| token.owner.icon }
      end
      (GAME_ROWS.times.map do |i|
        arr1.map { |row| row[i] || fill }
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
