# frozen_string_literal: true

module Connect4Game
  # computer supplies supplies results based on
  # a scoring system.  Moves are favored as follows:

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
  class G1 < Player
    include Connect4Game::Constants
    include Connect4Game::C4Constants
    # will need access to the board ?? or a copy of it.

    attr_accessor :center_column, :game_columns, :gameover, :connect4_board,
                  :config_testing

    def initialize(name: 'Player', icon: '', desc: '', id: nil, input: nil,
                   gameover: nil, board: nil)
      super(name: name, icon: icon, desc: desc, id: id, input: input)
      @gameover = gameover
      @connect4_board = board
      @center_column = CENTER_COLUMN
      @game_columns = GAME_COLUMNS

      go = @gameover
      @config_testing = {
        win: lambda do |gameboard|
          return 1 if go.game_over?(gameboard: gameboard)

          0
        end, # game winning move
        bwin: lambda do |gameboard|
          return 1 if go.game_over?(gameboard: gameboard)

          0
        end, # block opponent's win
        dr3: ->(gameboard:) { go.diag_match_count(gameboard: gameboard, num: 3) }, # create 3 in a row
        cr3: ->(gameboard:) { go.col_match_count(gameboard: gameboard, num: 3) },
        rr3: ->(gameboard:) { go.row_match_count(gameboard: gameboard, num: 3) },
        bdr3: ->(gameboard:) { go.diag_match_count(gameboard: gameboard, num: 3) }, # attempt to block 3 in a row
        bcr3: ->(gameboard:) { go.col_match_count(gameboard: gameboard, num: 3) },
        brr3: ->(gameboard:) { go.row_match_count(gameboard: gameboard, num: 3) },
        dr2: ->(gameboard:) { go.diag_match_count(gameboard: gameboard, num: 2) }, # creat 2 in a row
        rr2: ->(gameboard:) { go.row_match_count(gameboard: gameboard, num: 2) },
        cr2: ->(gameboard:) { go.col_match_count(gameboard: gameboard, num: 2) },
        bdr2: ->(gameboard:) { go.diag_match_count(gameboard: gameboard, num: 2) }, # attempt to block 2 in a row
        bcr2: ->(gameboard:) { go.col_match_count(gameboard: gameboard, num: 2) },
        brr2: ->(gameboard:) { go.row_match_count(gameboard: gameboard, num: 2) }
      }
    end

    def place_token(token)
      scores = calculate_scores(nextstates: token.next_states)
      nextstate = select_position(scores: scores)
      token.cur_state = nextstate
      token
    end

    def select_position(scores: nil)
      max_total_score = scores.values.map do |scores|
        scores[:total_score]
      end.max

      # reduce scores to an array of [state, values]
      arr = scores.to_a.select do |_nextstate, value|
        value[:total_score] == max_total_score
      end

      arr.sample[0] # return a single nextstate.
    end

    def calculate_scores(nextstates: nil)
      scores = {}

      nextstates.each do |nextstate|
        config_score = score_configs(nextstate: nextstate)
        pos_score = calc_pos_score(nextstate: nextstate)
        scores[nextstate] = { total_score: config_score + pos_score,
                              config_score: config_score,
                              pos_score: pos_score }
      end
      scores
    end

    def score_configs(nextstate: nil)
      # sjh - improvement, see if the proposed config can increase the score
      # before doing the work.
      config_scores = []
      SCORE_POSITIONS.each_key do |key|
        config_scores << calc_config_score(nextstate: nextstate, config: key)
      end
      config_scores.max
    end

    def calc_pos_score(nextstate: nil)
      x = (nextstate.col - center_column).abs
      (game_columns - x)
    end

    def calc_config_score(nextstate: nil,
                          config: nil)
      opponent_icon = 'X'
      opponent_icon = 'O' if icon == 'X'
      use_icon = icon
      use_icon = opponent_icon if SCORE_POSITIONS[config][1] == :opponent_icon

      gameboard = connect4_board.xo_array
      before_loc_count = config_testing[config].call(gameboard: gameboard)
      token_test_pos(nextstate: nextstate, use_icon: use_icon)
      gameboard = connect4_board.xo_array
      after_loc_count = config_testing[config].call(gameboard: gameboard)
      undo_test_pos(nextstate: nextstate)
      puts "#{after_loc_count} < #{before_loc_count}, #{config.inspect}"

      # return a number, the config_score for nextstate and config
      return 0 unless after_loc_count > before_loc_count

      C4Constants::SCORE_POSITIONS[config][0]
    end

    def token_test_pos(nextstate: nil, use_icon: nil)
      token = Token.new(token_name: 'stone',
                        player_id: id,
                        icon: use_icon,
                        desc: 'game piece',
                        cur_state: TokenState.new)

      connect4_board.board[nextstate.col] << token
      connect4_board
    end

    def undo_test_pos(nextstate: nil)
      connect4_board.board[nextstate.col].pop
    end
  end
end
