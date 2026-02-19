# frozen_string_literal: true

require_relative '../lib/connect_four/gamestate'

describe Connect4::Gamestate do
  subject(:gs) { Connect4::Gamestate.new }

  context '#drop_token_on_col' do
    let(:token1) { Connect4::Token.new }
    let(:token2) { Connect4::Token.new }
    let(:token3) { Connect4::Token.new }
    it 'update token count' do
      expect { gs.drop_token_on_col(1, token1) }.to change { gs.token_count }.by(1)
      expect(gs.connect4_board[1].length).to eql(1)
      expect(token1.row).to eql(1)
      expect(token1.col).to eql(0)
    end

    it 'place second token' do
      expect { gs.drop_token_on_col(1, token1) }.to change { gs.token_count }.by(1)
      expect { gs.drop_token_on_col(1, token2) }.to change { gs.token_count }.by(1)
      expect(gs.connect4_board[1].length).to eql(2)
      expect(token2.row).to eql(1)
      expect(token2.col).to eql(1)
    end
    it 'place third token' do
      expect { gs.drop_token_on_col(1, token1) }.to change { gs.token_count }.by(1)
      expect { gs.drop_token_on_col(1, token2) }.to change { gs.token_count }.by(1)
      expect { gs.drop_token_on_col(2, token3) }.to change { gs.token_count }.by(1)
      expect(gs.connect4_board[2].length).to eql(1)
      expect(token3.row).to eql(2)
      expect(token3.col).to eql(0)
    end

    it 'fill one entire row.' do
      (0...6).each do |_i|
        gs.drop_token_on_col(0, Connect4::Token.new)
      end
      expect(gs.connect4_board[0].length).to eql(6)
      expect(gs.connect4_board[0][5].col).to eql(5)
      expect(gs.connect4_board[0][5].row).to eql(0)

      expect(gs.next_positions).to eql([1, 2, 3, 4, 5, 6])
    end
    it 'fill all rows, board is full.' do
      (0...7).each do |j|
        (0...6).each do |_i|
          gs.drop_token_on_col(j, Connect4::Token.new)
        end
        expect(gs.connect4_board[j].length).to eql(6)
        expect(gs.connect4_board[j][5].col).to eql(5)
        expect(gs.connect4_board[j][5].row).to eql(j)
      end
      expect(gs.next_positions).to eql([])
      expect(gs).to be_full
    end
  end
end

describe Connect4::Token do
end
