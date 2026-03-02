# frozen_string_literal: true

require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/player/human'
require_relative '../lib/connect_four/player/userinput'
require_relative '../lib/connect_four/gameplay/token'
require_relative '../lib/connect_four/connect4play/connect4tokenstate'
require_relative '../lib/connect_four/connect4play/c4nextstates'
require_relative '../lib/connect_four/connect4play/c4gameboard'

describe Connect4Game::C4NextStates do
  subject(:c4ns) { Connect4Game::C4NextStates.new }
  let(:board) { Connect4Game::C4GameBoard.new }
  let(:player1) { Connect4Game::Human }

  before do
    c4ns.connect4_board = board
  end

  describe '#request_next_states' do
    let(:token1state) { Connect4Game::Connect4TokenState.new(row: 0, col: 1) }
    let(:token1) { Connect4Game::Token.new(owner: player1, cur_state: token1state) }
    it 'next_states is a list of tokenstates' do
      result = c4ns.request_next_states(token1)
      expect(
        result.next_states.all? { |elem| elem.is_a?(Connect4Game::Connect4TokenState) }
      ).to eql(true)
    end
  end
end
