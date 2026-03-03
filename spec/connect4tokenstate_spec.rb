require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/gameplay/tokenstate'
require_relative '../lib/connect_four/connect4play/connect4tokenstate'

describe Connect4Game::Connect4TokenState do
  subject(:token) { described_class.new }

  describe '#row=() updates id' do
    it 'set row' do
      expect { token.row = 1 }.to change { token.id }.from([-1, -1].inspect).to([1, -1].inspect)
      expect(token.row).to eql(1)
    end
  end

  describe '#col=() updates id' do
    it 'set col' do
      expect { token.col = 1 }.to change { token.id }.from([-1, -1].inspect).to([-1, 1].inspect)
      expect(token.col).to eql(1)
    end
  end
end
