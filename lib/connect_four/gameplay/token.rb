# frozen_string_literal: true

# describes the generic game player token
module Connect4Game
  # game play piece
  class Token
    include Connect4Game::SaveGame

    attr_accessor :next_states, :cur_state, :owner, :token_name, :desc

    def initialize(token_name: '', owner: nil, desc: '',
                   cur_state: nil, next_states: [])
      @token_name = token_name
      @owner = owner
      @desc = desc
      @cur_state = cur_state
      @next_states = next_states
    end
  end
end
