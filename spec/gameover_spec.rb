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

describe Connect4Game::GameOver do
  context 'empty/full board' do
    let(:xo_array) { Array.new(6) { Array.new(7) { ' ' } } }
    subject(:go) { Connect4Game::GameOver.new(board: xo_array) }
    it '#empty?' do
      expect(go).not_to be_full
      expect(go).to be_empty
    end
  end

  context 'board full of Xs' do
    let(:xo_array) { Array.new(6) { Array.new(7) { 'X' } } }
    subject(:go) { Connect4Game::GameOver.new(board: xo_array) }
    it '#full?' do
      expect(go).to be_full
      expect(go).not_to be_empty
    end
  end

  context 'board full of Os' do
    let(:xo_array) { Array.new(6) { Array.new(7) { 'O' } } }
    subject(:go) { Connect4Game::GameOver.new(board: xo_array) }
    it '#full?' do
      expect(go).to be_full
      expect(go).not_to be_empty
    end
  end

  describe 'winner' do
    context '4 Xs on rows' do
      xo_array = Array.new(6) { Array.new(7) { ' ' } }
      testrows_wins = [['X', 'X', 'X', 'X', ' ', ' ', ' '],
                       [' ', 'X', 'X', 'X', 'X', ' ', ' '],
                       [' ', ' ', 'X', 'X', 'X', 'X', ' '],
                       [' ', ' ', ' ', 'X', 'X', 'X', 'X']]

      testrows_notwin = [['O', 'X', 'X', 'X', ' ', ' ', ' '],
                         [' ', 'X', 'O', 'X', 'X', ' ', ' '],
                         [' ', ' ', 'X', 'O', 'X', 'X', ' '],
                         [' ', ' ', ' ', 'X', 'O', 'X', 'X']]

      blankrow = Array.new(7) { ' ' }
      subject(:go) { Connect4Game::GameOver.new(board: xo_array) }

      it 'test rows, win' do
        (0...6).each do |i|
          testrows_wins.each do |row|
            go.gameboard[i] = row
            expect(go).to be_winner
            go.gameboard[i] = blankrow
          end
        end
      end

      it 'test rows, not win' do
        (0...6).each do |i|
          testrows_notwin.each do |row|
            go.gameboard[i] = row
            expect(go).not_to be_winner
            go.gameboard[i] = blankrow
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
      xo_array = Array.new(6) { Array.new(7) { ' ' } }

      testrows_wins = [['X', 'X', 'X', 'X', ' ', ' '],
                       [' ', 'X', 'X', 'X', 'X', ' '],
                       [' ', ' ', 'X', 'X', 'X', 'X']]

      testrows_notwin = [['O', 'X', 'X', 'X', ' ', ' '],
                         [' ', 'X', 'O', 'X', 'X', ' '],
                         [' ', ' ', 'X', 'O', 'X', 'X']]

      subject(:go) { Connect4Game::GameOver.new(board: xo_array) }
      it 'test cols, win' do
        (0...7).each do |i|
          testrows_wins.each do |row|
            board = transpose(xo_array)
            board[i] = row
            go.gameboard = transpose(board)
            expect(go).to be_winner
          end
        end
      end
      it 'test cols, not win' do
        (0...7).each do |i|
          testrows_notwin.each do |row|
            board = transpose(xo_array)
            board[i] = row
            go.gameboard = transpose(board)
            expect(go).not_to be_winner
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
      empty_array = Array.new(6) { Array.new(7) { ' ' } }
      subject(:go) { Connect4Game::GameOver.new(board: empty_array) }
      it 'test diagonals, win' do
        go.all_diag_coords.each do |coords|
          xo_array = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            xo_array[x][y] = 'O'
          end
          go.gameboard = xo_array
          # puts ''
          # p_array(go.gameboard)
          # puts ''
          expect(go).to be_winner
        end
      end
      it 'test diagonals, win' do
        go.all_diag_coords.each do |coords|
          stones = %w[X O]
          xo_array = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            xo_array[x][y] = stones.rotate![0]
          end
          go.gameboard = xo_array
          expect(go).not_to be_winner
        end
      end
    end
  end
end
