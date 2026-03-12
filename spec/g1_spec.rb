# frozen_string_literal: true

require_relative '../lib/connect_four/player/g1'

describe Connect4Game::G1 do
  let(:token) { Connect4Game::Token.new }
  let(:score1) { { total_score: 55, config_score: 50, pos_score: 5 } }
  let(:score2) { { total_score: 43, config_score: 40, pos_score: 3 } }
  let(:scores) { [score1, score2] }

  let(:ns) { Connect4Game::Connect4TokenState.new(row: 1, col: 1) }
  let(:gls) do
    instance_double(Connect4Game::G1Scoring,
                    calculate_scores: scores)
  end
  let(:board) { instance_double(Connect4Game::C4GameBoard) }
  let(:go) { instance_double(Connect4Game::C4GameOver) }

  subject(:g1p) do
    Connect4Game::G1.new(name: 'Player 1',
                         desc: '',
                         id: 1,
                         input: nil,
                         gameover: go,
                         board: board)
  end

  before do
    g1p.scoring = gls
  end

  context '#place_token' do
    it 'test' do
      allow(g1p).to receive(:select_position).and_return(ns)
      result = g1p.place_token(token)
      expect(result.is_a?(Connect4Game::Token)).to eql(true)
      expect(result.cur_state.is_a?(Connect4Game::Connect4TokenState)).to eql(true)
    end
  end
end
