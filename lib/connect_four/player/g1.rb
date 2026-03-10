# frozen_string_literal: true

module Connect4Game
  # computer supplies supplies results based on
  # a scoring system.
  #
  # moves with the same score
  # are chosen by which is closest to the middle
  # followed by random selection
  #
  # computer player which selects moves by scoring.
  class G1 < Player
    include Connect4Game::Constants
    include Connect4Game::C4Constants
    include Connect4Game::SaveGame
    # will need access to the board ?? or a copy of it.

    attr_accessor :scoring

    def initialize(name: 'Player', icon: '', desc: '', id: nil, input: nil,
                   gameover: nil, board: nil)
      super(name: name, icon: icon, desc: desc, id: id, input: input)
      @scoring = Connect4Game::G1Scoring.new(board: board,
                                             gameover: gameover)
    end

    def restore_state(**kwargs)
      @input = kwargs[:input]
      @scoring = Connect4Game::G1Scoring.new(board: kwargs[:board],
                                             gameover: kwargs[:gameover])
    end

    def place_token(token)
      scores = scoring.calculate_scores(player_icon: icon,
                                        nextstates: token.next_states)
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

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
