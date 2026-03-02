# frozen_string_literal: true

require_relative '../lib/connect_four/gameplay/token'
require_relative '../lib/connect_four/gameplay/tokenstate'
require_relative '../lib/connect_four/gameplay/node'
require_relative '../lib/connect_four/gameplay/nodemanager'

describe Connect4Game::NodeManager do
  subject(:nm) { described_class.new }

  context '#add_node' do
    let(:token) { Connect4Game::Token.new(token_name: 'stone 1') }
    it 'Add first token' do
      nm.add_node(token: token)
      expect(nm.last_node.token).to eql(token)
    end
  end
end
