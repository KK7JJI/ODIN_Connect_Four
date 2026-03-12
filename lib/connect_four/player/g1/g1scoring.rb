# frozen_string_literal: true

module Connect4Game
  # Moves are favored as follows:

  # win game
  # block opponent win
  # 3 - row diagonal
  # 3 - row column or row
  # block opponent 3 in a row
  # 2 - row diagonal
  # 2 - row column or row
  # Closest to center

  # moves with the same score
  # are chosen by which is closest to the middle
  # followed by random selection

  # computer player which selects moves by scoring.
  class G1Scoring
    include Connect4Game::Constants
    include Connect4Game::C4Constants

    attr_accessor :config_scoring, :gameover, :connect4_board,
                  :center_column, :game_columns

    def initialize(gameover: nil, board: nil)
      @gameover = gameover
      @connect4_board = board
      @center_column = CENTER_COLUMN
      @game_columns = GAME_COLUMNS
      @config_scoring = config_scoring_setup
    end

    def calculate_scores(player_icon: nil, nextstates: nil)
      scores = {}

      nextstates.each do |nextstate|
        config_score = score_configs(player_icon: player_icon,
                                     nextstate: nextstate)
        pos_score = calc_pos_score(nextstate: nextstate)
        scores[nextstate] = { total_score: config_score + pos_score,
                              config_score: config_score,
                              pos_score: pos_score }
      end
      scores
    end

    private

    def config_scoring_setup
      go = gameover

      score_if = ->(condition) { condition ? 1 : 0 }

      count = lambda do |method, num|
        ->(gameboard:) { go.public_send(method, gameboard: gameboard, num: num) }
      end

      { win: ->(gameboard:) { score_if.call(go.game_over?(gameboard: gameboard)) },
        bwin: ->(gameboard:) { score_if.call(go.game_over?(gameboard: gameboard)) },
        dr3: count.call(:row_match_count, 3),
        cr3: count.call(:diag_match_count, 3),
        rr3: count.call(:row_match_count, 3),
        bdr3: count.call(:row_match_count, 3),
        bcr3: count.call(:diag_match_count, 3),
        brr3: count.call(:row_match_count, 3),
        dr2: count.call(:row_match_count, 2),
        cr2: count.call(:diag_match_count, 2),
        rr2: count.call(:row_match_count, 2),
        bdr2: count.call(:row_match_count, 2),
        bcr2: count.call(:diag_match_count, 2),
        brr2: count.call(:row_match_count, 2) }
    end

    def score_configs(player_icon: nil, nextstate: nil)
      # sjh - improvement, see if the proposed config can increase the score
      # before doing the work.
      config_scores = []
      SCORE_POSITIONS.each_key do |key|
        config_scores << calc_config_score(player_icon: player_icon,
                                           nextstate: nextstate,
                                           config: key)
      end
      config_scores.max
    end

    def calc_pos_score(nextstate: nil)
      x = (nextstate.col - center_column).abs
      (game_columns - x)
    end

    def calc_config_score(player_icon: nil,
                          nextstate: nil,
                          config: nil)
      use_icon = icon_selection(player_icon: player_icon)

      before = config_scoring[config].call(gameboard: connect4_board.xo_array)
      token_test_pos(nextstate: nextstate, use_icon: use_icon)
      after = config_scoring[config].call(gameboard: connect4_board.xo_array)

      undo_test_pos(nextstate: nextstate)

      # return a number, the config_score for nextstate and config
      return 0 unless after > before

      C4Constants::SCORE_POSITIONS[config][0]
    end

    def icon_selection(player_icon: nil)
      opponent_icon = (player_icon == 'X' ? 'O' : 'X')
      SCORE_POSITIONS[config][1] == :opponent_icon ? opponent_icon : player_icon
    end

    def token_test_pos(nextstate: nil, use_icon: nil)
      token = Token.new(token_name: 'stone',
                        icon: use_icon,
                        cur_state: TokenState.new)

      connect4_board.board[nextstate.col] << token
      connect4_board
    end

    def undo_test_pos(nextstate: nil)
      connect4_board.board[nextstate.col].pop
    end
  end
end
