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

    it 'Add 4 tokens' do
      (0...4).each do |i|
        msg = "stone #{i}"
        token = Connect4Game::Token.new(token_name: msg)
        nm.add_node(token: token)
        expect(nm.last_node.token).to eql(token)
      end
    end
  end

  context '#all_nodes' do
    it 'Add 4 tokens' do
      tokens = []
      (0...4).each do |i|
        msg = "stone #{i}"
        token = Connect4Game::Token.new(token_name: msg)
        tokens << token
        nm.add_node(token: token)
      end
      # expect(nm.all_nodes.map(&:token)).to eql(tokens)
      nm.game_nodes
      tokens.reverse
      expect(nm.all_nodes.map(&:token)).to eql(tokens)
    end
  end

  context '#all_tokens' do
    it 'Add 4 tokens' do
      tokens = []
      (0...4).each do |i|
        msg = "stone #{i}"
        token = Connect4Game::Token.new(token_name: msg)
        tokens << token
        nm.add_node(token: token)
      end
      tokens.reverse
      expect(nm.played_tokens).to eql(tokens)
    end
  end
end
