require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/c4constants'
require_relative '../lib/connect_four/connect4play/c4placetokens'
require_relative '../lib/connect_four/gameplay/gameover'
require_relative '../lib/connect_four/connect4play/c4gameover'

describe Connect4Game::C4PlaceTokens do
  subject(:pt) { described_class.new }
  let(:player) { Connect4Game::Human.new }
  describe '#new_player_tokens' do
    it 'returns an array of tokens' do
      result = pt.new_player_tokens(player: player)
      expect(result.is_a?(Array)).to eql(true)
      expect(result.all? { |elem| elem.is_a?(Connect4Game::Token) }).to eql(true)
    end
  end

  describe '#place_new_tokens' do
    let(:gameover) { double(Connect4Game::C4GameOver) }
    let(:nextstates) { double(Connect4Game::NextStates) }
    let(:node_manager) { double(Connect4Game::NodeManager) }
    let(:board) { double(Connect4Game::C4GameBoard) }
    let(:token) { Connect4Game::Token.new }
    before do
      pt.node_manager = node_manager
      pt.gameover = gameover
      pt.nextstates = nextstates
      pt.connect4_board = board
    end
    it 'calls place token 5 times' do
      allow(pt.node_manager).to receive(:add_node)
      allow(pt.nextstates).to receive(:request_next_states)
      allow(pt).to receive(:new_tokens_per_turn).and_return(5)
      allow(pt.gameover).to receive(:game_over?).and_return(false)
      expect(pt).to receive(:place_token).exactly(5).times
      pt.place_new_tokens(player: player)
    end

    it 'calls update_board 5 times' do
      allow(pt.node_manager).to receive(:add_node)
      allow(pt.nextstates).to receive(:request_next_states)
      allow(pt).to receive(:new_tokens_per_turn).and_return(5)
      allow(player).to receive(:place_token)
      allow(pt.gameover).to receive(:game_over?).and_return(false)
      expect(pt.connect4_board).to receive(:update_board).exactly(5).times
      pt.place_new_tokens(player: player)
    end
  end
end
