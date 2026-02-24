# frozen_string_literal: true

require_relative '../lib/connect_four/gameplay'
require_relative '../lib/connect_four/connect4play'

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

describe Connect4Game::Connect4play do
  subject(:gs) { described_class.new }

  context '#update_board' do
    let(:token1state) { Connect4Game::Connect4TokenState.new(row: 1, col: 0) }
    let(:token2state) { Connect4Game::Connect4TokenState.new(row: 1, col: 1) }
    let(:token3state) { Connect4Game::Connect4TokenState.new(row: 2, col: 0) }

    let(:token1) { Connect4Game::Token.new(cur_state: token1state) }
    let(:token2) { Connect4Game::Token.new(cur_state: token2state) }
    let(:token3) { Connect4Game::Token.new(cur_state: token3state) }

    it 'update token count' do
      expect { gs.update_board(token1) }.to change { gs.token_count }.by(1)
      expect(gs.connect4_board[1].length).to eql(1)
    end

    it 'place second token' do
      gs.update_board(token1)
      gs.update_board(token2)
      expect(gs.token_count).to eql(2)
      expect(gs.connect4_board[1].length).to eql(2)
    end
    it 'place third token' do
      gs.update_board(token1)
      gs.update_board(token2)
      gs.update_board(token3)
      expect(gs.token_count).to eql(3)
      expect(gs.connect4_board[2].length).to eql(1)
    end

    it 'fill one entire row.' do
      (0...6).each do |i|
        token_state = Connect4Game::Connect4TokenState.new(row: 0, col: i)
        token = Connect4Game::Token.new(cur_state: token_state)
        gs.update_board(token)
      end
      expect(gs.connect4_board[0].length).to eql(6)
      expect(gs).not_to be_full
      expect(gs.available_columns).to eql([1, 2, 3, 4, 5, 6])
    end
    it 'fill all rows, board is full.' do
      (0...7).each do |j|
        (0...6).each do |i|
          token_state = Connect4Game::Connect4TokenState.new(row: j, col: i)
          token = Connect4Game::Token.new(cur_state: token_state)
          gs.update_board(token)
        end
        expect(gs.connect4_board[j].length).to eql(6)
        expect(gs.connect4_board[j][5].cur_state.col).to eql(5)
        expect(gs.connect4_board[j][5].cur_state.row).to eql(j)
      end
      expect(gs.available_columns).to eql([])
      expect(gs).to be_full
      expect(gs).to be_game_over
    end
  end
end
