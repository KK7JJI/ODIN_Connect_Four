# frozen_string_literal: true

require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/c4constants'
require_relative '../lib/connect_four/connect4play/c4renderer'

describe Connect4Game::C4Renderer do
  subject(:c4render) { described_class.new }
  let(:player1) { Connect4Game::Human.new(name: 'Player 1', icon: 'X') }
  let(:player2) { Connect4Game::Human.new(name: 'Player 2', icon: 'O') }

  before do
    c4render.connect4_board = Connect4Game::C4GameBoard.new
    c4render.connect4_board.renderer = c4render
  end

  def print_board(arr)
    arr.each { |row| puts row.inspect }
  end

  describe '#return_board_with_borders' do
    it 'empty gameboard' do
      result = c4render.return_board_with_borders
      expect(result.count(' ')).to eql(6 * 7)
      expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(6 * 7 + 6)
      expect(result.is_a?(String)).to eql(true)
    end
    it 'fill columns one at a time Xs' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          c4render.connect4_board.update_board(
            Connect4Game::Token.new(player_id: player1.id,
                                    icon: player1.icon,
                                    cur_state: cur_state)
          )
        end
        result = c4render.return_board_with_borders
        expect(result.count('X')).to eql((col + 1) * 6)
        expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(6 * 7 + 6)
        expect(result.is_a?(String)).to eql(true)
      end
    end

    it 'fill columns one at a time Os' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          c4render.connect4_board.update_board(
            Connect4Game::Token.new(player_id: player2.id,
                                    icon: player2.icon,
                                    cur_state: cur_state)
          )
        end
        result = c4render.return_board_with_borders
        expect(result.count('O')).to eql((col + 1) * 6)
        expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(6 * 7 + 6)
        expect(result.is_a?(String)).to eql(true)
      end
    end
  end

  describe '#return_board_without_borders' do
    it 'empty gameboard' do
      result = c4render.return_board_without_borders
      expect(result.count(' ')).to eql(6 * 7)
      expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(0)
      expect(result.is_a?(String)).to eql(true)
    end
    it 'fill columns one at a time Xs' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          c4render.connect4_board.update_board(
            Connect4Game::Token.new(player_id: player1.id,
                                    icon: player1.icon,
                                    cur_state: cur_state)
          )
        end
        result = c4render.return_board_without_borders
        expect(result.count('X')).to eql((col + 1) * 6)
        expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(0)
        expect(result.is_a?(String)).to eql(true)
      end
    end

    it 'fill columns one at a time Os' do
      result = ''
      (0...7).each do |col|
        (0...6).each do |row|
          cur_state = Connect4Game::Connect4TokenState.new(col: col, row: row)
          c4render.connect4_board.update_board(
            Connect4Game::Token.new(player_id: player2.id,
                                    icon: player2.icon,
                                    cur_state: cur_state)
          )
        end
        result = c4render.return_board_without_borders
        expect(result.count('O')).to eql((col + 1) * 6)
        expect(result.count(Connect4Game::C4Constants::BOX_CHARS[:vert_line])).to eql(0)
        expect(result.is_a?(String)).to eql(true)
      end
    end
  end
end
