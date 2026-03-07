# frozen_string_literal: true

require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/c4constants'
require_relative '../lib/connect_four/save_game'
require_relative '../lib/connect_four/gameplay'
require_relative '../lib/connect_four/connect4play'
require_relative '../lib/connect_four/connect4play/c4gameboard'
require_relative '../lib/connect_four/gameplay/token'

describe Connect4Game::C4GameBoard do
  subject(:gb) { described_class.new }
  before do
    gb.renderer = Connect4Game::C4Renderer.new
    gb.renderer.connect4_board = gb
  end

  def print_board(xo_array)
    xo_array.each do |row|
      puts row.inspect
    end
  end

  describe '#update_board' do
    it 'add a token to a specific game column' do
      token = Connect4Game::Token.new
      (0...7).to_a.each do |col|
        token.cur_state = Connect4Game::Connect4TokenState.new(col: col)
        expect { gb.update_board(token) }.to change { gb.board[col].length }.by(1)
        expect(gb.board[col][0].is_a?(Connect4Game::Token)).to eql(true)
      end
    end
  end

  describe '#open_columns' do
    it 'return an array identifing col numbers which are not full.' do
      result = [0, 1, 2, 3, 4, 5, 6]
      (0...7).to_a.each do |col|
        (0...6).to_a.each do |i|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: i)
          gb.update_board(Connect4Game::Token.new(cur_state: cur_state))
        end

        result.delete(col)
        expect(gb.open_columns).to eql(result)
      end
    end
  end
  describe '#empty' do
    it 'returns true if the board is empty' do
      gb.board = Array.new(7) { [] }
      expect(gb).to be_empty
    end
    it 'returns false if the board is not empty' do
      gb.board = Array.new(7) { [] }
      cur_state = Connect4Game::Connect4TokenState.new(col: 0, row: 0)
      gb.update_board(Connect4Game::Token.new(cur_state: cur_state))
      expect(gb).not_to be_empty
    end
  end
  describe '#full' do
    it 'returns true if the board is full.' do
      (0...7).to_a.each do |col|
        (0...6).to_a.each do |i|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: i)
          gb.update_board(Connect4Game::Token.new(cur_state: cur_state))
        end
      end
      expect(gb).to be_full
    end
    it 'returns false if the board is not full.' do
      (0...7).to_a.each do |col|
        (0...6).to_a.each do |i|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: i)
          gb.update_board(Connect4Game::Token.new(cur_state: cur_state))
        end
      end
      i = rand(gb.board.length)
      j = rand(gb.board[i].length)
      gb.board[i].delete_at(j)
      expect(gb).not_to be_full
    end
  end
  describe '#return_xo_array' do
    let(:player1) { Connect4Game::Human.new(id: 1, name: 'Player 1', icon: 'X') }
    let(:player2) { Connect4Game::Human.new(id: 2, name: 'Player 2', icon: 'O') }
    it 'empty gameboard' do
      result = gb.xo_array
      expect(result.flatten.all? { |elem| elem == ' ' }).to eql(true)
      expect(result.is_a?(Array)).to eql(true)
      expect(result.all? { |row| row.is_a?(Array) })
    end
    it 'one token on column 0' do
      token = Connect4Game::Token.new(player_id: player1.id, icon: player1.icon)
      token.cur_state = Connect4Game::Connect4TokenState.new(col: 0)
      gb.update_board(token)
      result = gb.xo_array
      expect(result[5][0]).to eql('X')
      expect(result.flatten.count(' ')).to eql(6 * 7 - 1)
      expect(result.is_a?(Array)).to eql(true)
      expect(result.all? { |row| row.is_a?(Array) })
    end

    it 'fill columns one at a time Xs' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          gb.update_board(
            Connect4Game::Token.new(player_id: player1.id,
                                    icon: player1.icon,
                                    cur_state: cur_state)
          )
        end
        result = gb.xo_array
        expect(result.flatten.count('X')).to eql((col + 1) * 6)
      end
      expect(result.is_a?(Array)).to eql(true)
      expect(result.all? { |row| row.is_a?(Array) })
    end
    it 'fill columns one at a time Os' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          gb.update_board(
            Connect4Game::Token.new(player_id: player2.id,
                                    icon: player2.icon,
                                    cur_state: cur_state)
          )
        end
        result = gb.xo_array
        expect(result.flatten.count('O')).to eql((col + 1) * 6)
      end
      expect(result.is_a?(Array)).to eql(true)
      expect(result.all? { |row| row.is_a?(Array) })
    end
  end
end
