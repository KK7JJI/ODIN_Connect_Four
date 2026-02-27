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
require_relative '../lib/connect_four/connect4play/gameover/rowmatch'
require_relative '../lib/connect_four/connect4play/gameover/colmatch'
require_relative '../lib/connect_four/connect4play/gameover/diagmatch'

describe Connect4Game::GameOver do
  context 'empty/full board' do
    let(:xo_array) { Array.new(6) { Array.new(7) { ' ' } } }
    subject(:go) { Connect4Game::GameOver.new }
    it '#empty?' do
      expect(go.full?(xo_array)).to eql(false)
      expect(go.empty?(xo_array)).to eql(true)
    end
  end

  context 'board full of Xs' do
    let(:xo_array) { Array.new(6) { Array.new(7) { 'X' } } }
    subject(:go) { Connect4Game::GameOver.new }
    it '#full?' do
      expect(go.full?(xo_array)).to eql(true)
      expect(go.empty?(xo_array)).to eql(false)
    end
  end

  context 'board full of Os' do
    let(:xo_array) { Array.new(6) { Array.new(7) { 'O' } } }
    subject(:go) { Connect4Game::GameOver.new }
    it '#full?' do
      expect(go.full?(xo_array)).to eql(true)
      expect(go.empty?(xo_array)).to eql(false)
    end
  end

  describe 'winner' do
    context '4 Xs on rows' do
      testrows_wins = [['X', 'X', 'X', 'X', ' ', ' ', ' '],
                       [' ', 'X', 'X', 'X', 'X', ' ', ' '],
                       [' ', ' ', 'X', 'X', 'X', 'X', ' '],
                       [' ', ' ', ' ', 'X', 'X', 'X', 'X']]

      testrows_notwin = [['O', 'X', 'X', 'X', ' ', ' ', ' '],
                         [' ', 'X', 'O', 'X', 'X', ' ', ' '],
                         [' ', ' ', 'X', 'O', 'X', 'X', ' '],
                         [' ', ' ', ' ', 'X', 'O', 'X', 'X']]

      subject(:go) { Connect4Game::GameOver.new }

      it 'test rows, win' do
        (0...6).each do |i|
          testrows_wins.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            gameboard[i] = row
            expect(go.winner?(gameboard)).to eql(true)
          end
        end
      end

      it 'test rows, not win' do
        (0...6).each do |i|
          testrows_notwin.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            gameboard[i] = row
            expect(go.winner?(gameboard)).to eql(false)
          end
        end
      end
    end

    def transpose(arr)
      arr[0].length.times.map do |i|
        arr.map { |row| row[i] }
      end
    end

    context '4 X on columns' do
      testrows_wins = [['X', 'X', 'X', 'X', ' ', ' '],
                       [' ', 'X', 'X', 'X', 'X', ' '],
                       [' ', ' ', 'X', 'X', 'X', 'X']]

      testrows_notwin = [['O', 'X', 'X', 'X', ' ', ' '],
                         [' ', 'X', 'O', 'X', 'X', ' '],
                         [' ', ' ', 'X', 'O', 'X', 'X']]

      subject(:go) { Connect4Game::GameOver.new }
      it 'test cols, win' do
        (0...7).each do |i|
          testrows_wins.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            board = transpose(gameboard)
            board[i] = row
            gameboard = transpose(board)
            expect(go.winner?(gameboard)).to eql(true)
          end
        end
      end
      it 'test cols, not win' do
        (0...7).each do |i|
          testrows_notwin.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            board = transpose(gameboard)
            board[i] = row
            gameboard = transpose(board)
            expect(go.winner?(gameboard)).to eql(false)
          end
        end
      end
    end

    def p_array(arr)
      arr.each do |row|
        puts row.inspect
      end
    end

    context '4 O on diagonals' do
      subject(:go) { Connect4Game::GameOver.new }

      it 'test diagonals, win' do
        go.diag_match.all_diag_coords.each do |coords|
          gameboard = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            gameboard[x][y] = 'O'
          end
          expect(go.winner?(gameboard)).to eql(true)
        end
      end
      it 'test diagonals, win' do
        go.diag_match.all_diag_coords.each do |coords|
          stones = %w[X O]
          gameboard = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            gameboard[x][y] = stones.rotate![0]
          end
          expect(go.winner?(gameboard)).to eql(false)
        end
      end
    end
  end
end
