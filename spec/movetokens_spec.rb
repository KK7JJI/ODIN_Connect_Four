require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/gameplay/movetokens'

describe Connect4Game::MoveTokens do
  subject(:mt) { Connect4Game::MoveTokens.new }
  let(:player) { Connect4Game::Human.new }
  let(:go) { double(Connect4Game::GameOver) }
  let(:nm) { double(Connect4Game::NodeManager) }
  let(:ns) { double(Connect4Game::NextStates) }
  let(:token) { Connect4Game::Token.new }

  before do
    mt.gameover = go
    mt.nextstates = ns
    mt.node_manager = nm
  end
  describe '#move_player_tokens' do
    before do
      allow(mt).to receive(:token_moves_per_turn).and_return(5)
      allow(mt.gameover).to receive(:game_over?).and_return(false)
      allow(mt.nextstates).to receive(:next_states).and_return([])
      allow(player).to receive(:move_token).and_return(token)
      allow(mt.node_manager).to receive(:add_node)
    end
    it 'move token loop executes 5 times' do
      expect(player).to receive(:move_token).exactly(5).times
      mt.move_player_tokens(player: player)
    end
  end
end
