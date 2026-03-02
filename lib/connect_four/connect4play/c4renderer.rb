# frozen_string_literal: true

module Connect4Game
  # generate an ascii representation of the gamestate
  class C4Renderer
    include Connect4Game::Constants
    attr_accessor :connect4_board, :rendered_board, :rendered_board_nb, :xo_array

    def initialize(board: nil)
      @connect4_board = board
      @xo_array = []
      @rendered_board = ''
      @rendered_board_nb = ''
    end

    def return_xo_array(response: -> { xo_array })
      requested_state_rep(response: response)
    end

    def return_board_with_borders(response: -> { rendered_board })
      requested_state_rep(response: response)
    end

    def return_board_without_borders(response: -> { rendered_board_nb })
      requested_state_rep(response: response)
    end

    private

    def requested_state_rep(response:)
      self.xo_array = xo_rep_of_board
      self.rendered_board = render_board_with_borders
      self.rendered_board_nb = render_board_without_borders

      response&.call
    end

    def icon(token)
      token.icon
    end

    def xo_rep_of_board
      # player 1: X, player 2: O
      connect4_board.xo_array
    end

    def render_board_with_borders
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

    def render_board_without_borders
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
