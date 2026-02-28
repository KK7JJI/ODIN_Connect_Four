# frozen_string_literal: true

require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/player'
require_relative '../lib/connect_four/player/human'
require_relative '../lib/connect_four/player/random'
require_relative '../lib/connect_four/player/userinput'
require_relative '../lib/connect_four/gameplay'
require_relative '../lib/connect_four/gameplay/token'
require_relative '../lib/connect_four/gameplay/tokenstate'
require_relative '../lib/connect_four/gameplay/simpleasciirenderer'
require_relative '../lib/connect_four/gameplay/node'
require_relative '../lib/connect_four/connect4play'
require_relative '../lib/connect_four/connect4play/connect4tokenstate'
require_relative '../lib/connect_four/connect4play/c4asciirenderer'
require_relative '../lib/connect_four/connect4play/gameover'

player1 = Connect4Game::Human.new(name: 'Player 1', icon: 'X')
player2 = Connect4Game::Human.new(name: 'Player 2', icon: 'O')
players = [player1, player2]

describe Connect4Game::Connect4play do
  subject(:c4p) { described_class.new(players: players) }

  context 'display board' do
    let(:token1state) { Connect4Game::Connect4TokenState.new(row: 0, col: 1) }
    let(:token2state) { Connect4Game::Connect4TokenState.new(row: 1, col: 1) }
    let(:token3state) { Connect4Game::Connect4TokenState.new(row: 0, col: 2) }

    let(:token1) { Connect4Game::Token.new(owner: player1, cur_state: token1state) }
    let(:token2) { Connect4Game::Token.new(owner: player1, cur_state: token2state) }
    let(:token3) { Connect4Game::Token.new(owner: player1, cur_state: token3state) }

    before do
      allow(c4p).to receive(:setup_new_game)
    end

    it 'empty board' do
      expect(c4p.render_gamestate.count(' ')).to eql(42)
    end

    it 'one token on the board' do
      c4p.update_board(token1)
      expect(c4p.render_gamestate.count('X')).to eql(1)
      expect(c4p.render_gamestate.count(' ')).to eql(41)
    end
    it 'two tokens on the board' do
      c4p.update_board(token1)
      c4p.update_board(token2)
      expect(c4p.render_gamestate.count('X')).to eql(2)
      expect(c4p.render_gamestate.count(' ')).to eql(40)
    end
    it 'three tokens on the board' do
      c4p.update_board(token1)
      c4p.update_board(token2)
      c4p.update_board(token3)
      expect(c4p.render_gamestate.count('X')).to eql(3)
      expect(c4p.render_gamestate.count(' ')).to eql(39)
    end
    it 'fill one entire row.' do
      (0...6).each do |i|
        token_state = Connect4Game::Connect4TokenState.new(row: i, col: 0)
        token = Connect4Game::Token.new(owner: player2, cur_state: token_state)
        c4p.update_board(token)
      end
      expect(c4p.render_gamestate.count('O')).to eql(6)
      expect(c4p.render_gamestate.count(' ')).to eql(36)
    end
    it 'fill all rows, board is full.' do
      (0...7).each do |j|
        (0...6).each do |i|
          token_state = Connect4Game::Connect4TokenState.new(row: i, col: j)
          token = Connect4Game::Token.new(owner: player2, cur_state: token_state)
          c4p.update_board(token)
        end
        expect(c4p.render_gamestate.count('O')).to eql(6 * (j + 1))
        expect(c4p.render_gamestate.count(' ')).to eql(42 - 6 * (j + 1))
      end
      expect(c4p.render_gamestate.count('O')).to eql(42)
    end
  end
end
