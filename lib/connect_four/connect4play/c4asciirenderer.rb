# frozen_string_literal: true

module Connect4Game
  # generate an ascii representation of the gamestate
  class C4Ascii4Renderer
    include Connect4Game::Constants
    attr_accessor :connect4_board, :rendered_board, :rendered_board_nb,
                  :borders, :xo_array

    def initialize
      @xo_array = []
      @rendered_board = ''
      @rendered_board_nb = ''
    end

    def return_xo_array(board:, response: -> { xo_array })
      ascii_state_rep(board: board, response: response)
    end

    def render(board:, response: -> { rendered_board })
      ascii_state_rep(board: board, response: response)
    end

    def ascii_state_rep(board:, response:)
      return 'no data' if board.nil?

      self.xo_array = transpose(board)
      self.rendered_board = board_with_borders
      self.rendered_board_nb = board_without_borders

      response&.call
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

    def board_with_borders
      disp = []

      top_border = top_border(GAME_COLUMNS)
      middle_divider = middle_divider(GAME_COLUMNS)
      bottom_border = bottom_border(GAME_COLUMNS)

      disp << top_border
      xo_array.each do |row|
        disp << middle_values(row)
        disp << middle_divider
      end

      disp[-1] = bottom_border
      disp.join("\n")
    end

    def board_without_borders
      disp = []
      xo_array.each do |row|
        disp << row.join('')
      end
      disp.join("\n")
    end

    def top_border(cols)
      result = String.new(BOX_CHARS[:top_left_corner])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:top_vertical_line] + BOX_CHARS[:horz_line]) * (cols - 1)
      result << BOX_CHARS[:top_right_corner]
      result
    end

    def middle_values(arr)
      result = String.new(BOX_CHARS[:vert_line])
      result << arr.join(BOX_CHARS[:vert_line])
      result << BOX_CHARS[:vert_line]
      result
    end

    def middle_divider(cols)
      result = String.new(BOX_CHARS[:left_horz_line])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:cross] + BOX_CHARS[:horz_line]) * (cols - 1)
      result << BOX_CHARS[:right_horz_line]
      result
    end

    def bottom_border(cols)
      result = String.new(BOX_CHARS[:bot_left_corner])
      result << BOX_CHARS[:horz_line]
      result << (BOX_CHARS[:bot_vertical_line] + BOX_CHARS[:horz_line]) * (cols - 1)
      result << BOX_CHARS[:bot_right_corner]
      result
    end
  end
end
