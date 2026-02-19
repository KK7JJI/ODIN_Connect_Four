require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/gameplay'

describe Connect4::Player do # rubocop:disable Metrics/BlockLength
  positions = [0, 1, 2, 4, 5, 6]
  let(:connect4) { double('Connect4', next_positions: positions) }
  subject(:human) { Connect4::Human.new(game: connect4) }

  context '#valid_positions' do
    it 'not numeric' do
      expect(human.valid_position?('@')).to eql(false)
    end
    it 'not numeric' do
      expect(human.valid_position?('a')).to eql(false)
    end
    it 'not in range < 0' do
      expect(human.valid_position?('-1')).to eql(false)
    end
    it 'not in range > 6' do
      expect(human.valid_position?('7')).to eql(false)
    end
    it 'invalid next position = 3' do
      expect(human.valid_position?('3')).to eql(false)
    end
    it 'in range' do
      expect(human.valid_position?('6')).to eql(true)
    end
    it 'in range' do
      expect(human.valid_position?('0')).to eql(true)
    end
  end

  context 'human#place_new_token' do
    before do
      allow($stdout).to receive(:write)
    end
    it 'valid input: 6' do
      allow($stdin).to receive(:gets).and_return("6\n")
      result = human.place_new_token
      expect(result).to eql(6)
      expect(result.is_a?(Integer)).to eql(true)
    end
    it 'two attempts: 0' do
      allow($stdin).to receive(:gets).and_return("a\n", "0\n")
      result = human.place_new_token
      expect(result).to eql(0)
      expect(result.is_a?(Integer)).to eql(true)
    end
    it 'three attempts: 0' do
      allow($stdin).to receive(:gets).and_return("a\n", "3\n", "0\n")
      result = human.place_new_token
      expect(result).to eql(0)
      expect(result.is_a?(Integer)).to eql(true)
    end
  end

  subject(:random) { Connect4::Random.new(game: connect4) }
  context 'random#place_new_token' do
    it 'random input: 0' do
      result = random.place_new_token
      expect(result.is_a?(Integer)).to eql(true)
      expect(positions.include?(result)).to eql(true)
    end
  end
end
