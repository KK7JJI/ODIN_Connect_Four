# frozen_string_literal: true

require_relative '../lib/connect_four/player/g1/g1scoring'

describe Connect4Game::G1Scoring do
  let(:player_icon) { 'X' }
  let(:nextstate) { Connect4Game::Connect4TokenState.new(row: 0, col: 3) }
  let(:nextstates) { [nextstate] }

  let(:board) { instance_double(Connect4Game::C4GameBoard) }
  let(:gameover) { instance_double(Connect4Game::C4GameBoard) }
  subject(:g1s) do
    Connect4Game::G1Scoring.new(gameover: gameover,
                                board: board)
  end

  context '#calculate_scores' do
    it 'test' do
      allow(g1s).to receive(:score_configs).and_return(50)
      allow(g1s).to receive(:calc_pos_score).and_return(5)
      result = g1s.calculate_scores(player_icon: player_icon,
                                    nextstates: nextstates)
      expect(result.is_a?(Hash)).to eql(true)
      expect(result[nextstate][:total_score]).to eql(55)
      expect(result[nextstate][:config_score]).to eql(50)
      expect(result[nextstate][:pos_score]).to eql(5)
    end
  end
end
