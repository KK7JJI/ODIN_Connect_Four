# frozen_string_literal: true

# describes the generic game player token
module Connect4Game
  # game play piece
  class Token
    include Connect4Game::SaveGame

    attr_accessor :next_states, :cur_state, :player_id, :token_name, :desc, :icon

    def initialize(token_name: '', player_id: nil, desc: '', icon: '',
                   cur_state: nil, next_states: [])
      @token_name = token_name
      @player_id = player_id
      @icon = icon
      @desc = desc
      @cur_state = cur_state
      @next_states = next_states
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
