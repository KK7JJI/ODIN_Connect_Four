# frozen_string_literal: true

require_relative '../lib/connect_four/gameplay'
require_relative '../lib/connect_four/connect4play'
require_relative '../lib/connect_four/player'

describe Connect4Game::Player do # rubocop:disable Metrics/BlockLength
  let(:next_positions) { [0, 1, 2, 4, 5, 6] }
  next_states = []
  [0, 1, 2, 4, 5, 6].to_a.map do |i|
    next_states << Connect4Game::Connect4TokenState.new(row: i, col: 0)
  end
  let(:token) { Connect4Game::Token.new(next_states: next_states) }

  context '#valid_positions' do
    subject(:human) { Connect4Game::Human.new }
    it 'not numeric' do
      expect(human.valid_selection?('@', next_positions)).to eql(false)
    end
    it 'not numeric' do
      expect(human.valid_selection?('a', next_positions)).to eql(false)
    end
    it 'not in range < 0' do
      expect(human.valid_selection?('-1', next_positions)).to eql(false)
    end
    it 'not in range > 6' do
      expect(human.valid_selection?('7', next_positions)).to eql(false)
    end
    it 'invalid next position = 3' do
      expect(human.valid_selection?('3', next_positions)).to eql(false)
    end
    it 'in range' do
      expect(human.valid_selection?('6', next_positions)).to eql(true)
    end
    it 'in range' do
      expect(human.valid_selection?('0', next_positions)).to eql(true)
    end
  end

  context 'human#take_turn' do
    subject(:human) { Connect4Game::Human.new }

    it 'valid input: 6' do
      allow(human).to receive(:user_input).and_return(6)
      expect { human.place_token(token) }.to change { human.tokens.length }.by(1)
      expect(human.tokens[-1].class).to eql(Connect4Game::Token)
      expect(human.tokens[-1].cur_state.class).to eql(Connect4Game::Connect4TokenState)
      expect(human.tokens[-1].cur_state.id).to eql([6, 0].inspect)
    end
  end

  context 'random#take_turn' do
    subject(:random) { Connect4Game::Random.new }
    it 'random input: 0' do
      random.place_token(token)
      expect { random.place_token(token) }.to change { random.tokens.length }.by(1)
      expect(random.tokens[-1].class).to eql(Connect4Game::Token)
      expect(random.tokens[-1].cur_state.class).to eql(Connect4Game::Connect4TokenState)
    end
  end
end
