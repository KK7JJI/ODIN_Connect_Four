# frozen_string_literal: true

require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/player/human'
require_relative '../lib/connect_four/player/random'
require_relative '../lib/connect_four/player/userinput'
require_relative '../lib/connect_four/gameplay/tokenstate'
require_relative '../lib/connect_four/connect4play/connect4tokenstate'
require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/connect4play/c4gameboard'

describe Connect4Game::C4GameBoard do
  subject(:gb) { described_class.new }
  before do
    gb.renderer = Connect4Game::C4Renderer.new
    gb.renderer.connect4_board = gb
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
  describe '#xo_array' do
    it 'calls c4render return_xo_array' do
      expect(gb.renderer).to receive(:return_xo_array)
      gb.xo_array
    end
    it 'error is raised if a render class is not specified' do
      gb.renderer = nil
      expect { gb.xo_array }.to raise_error(NotImplementedError)
    end
  end
end
