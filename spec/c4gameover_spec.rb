require_relative '../lib/connect_four/constants'
require_relative '../lib/connect_four/c4constants'
require_relative '../lib/connect_four/connect4play/c4gameover'
require_relative '../lib/connect_four/connect4play/c4gameover/rowmatch'
require_relative '../lib/connect_four/connect4play/c4gameover/colmatch'
require_relative '../lib/connect_four/connect4play/c4gameover/diagmatch'

describe Connect4Game::C4GameOver do
  subject(:go) { described_class.new }
  let(:gb) { instance_double(Connect4Game::C4GameBoard) }
  before do
    go.connect4_board = gb
  end

  describe 'winner' do
    let(:gb) { instance_double(Connect4Game::C4GameBoard) }
    before do
      go.connect4_board = gb
    end
    context '4 Xs on rows' do
      testrows_wins = [['X', 'X', 'X', 'X', ' ', ' ', ' '],
                       [' ', 'X', 'X', 'X', 'X', ' ', ' '],
                       [' ', ' ', 'X', 'X', 'X', 'X', ' '],
                       [' ', ' ', ' ', 'X', 'X', 'X', 'X']]

      testrows_notwin = [['O', 'X', 'X', 'X', ' ', ' ', ' '],
                         [' ', 'X', 'O', 'X', 'X', ' ', ' '],
                         [' ', ' ', 'X', 'O', 'X', 'X', ' '],
                         [' ', ' ', ' ', 'X', 'O', 'X', 'X']]

      it 'test rows, win' do
        (0...6).each do |i|
          testrows_wins.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            gameboard[i] = row
            allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
            expect(go.winner?).to eql(true)
          end
        end
      end

      it 'test rows, not win' do
        (0...6).each do |i|
          testrows_notwin.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            gameboard[i] = row
            allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
            expect(go.winner?).to eql(false)
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

      it 'test cols, win' do
        (0...7).each do |i|
          testrows_wins.each do |row|
            gameboard = Array.new(6) { Array.new(7) { ' ' } }
            board = transpose(gameboard)
            board[i] = row
            gameboard = transpose(board)
            allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
            expect(go.winner?).to eql(true)
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
            allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
            expect(go.winner?).to eql(false)
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
      it 'test diagonals, win' do
        go.diag_matching.all_diag_coords.each do |coords|
          gameboard = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            gameboard[x][y] = 'O'
          end
          allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
          expect(go.winner?).to eql(true)
        end
      end
      it 'test diagonals, win' do
        go.diag_matching.all_diag_coords.each do |coords|
          stones = %w[X O]
          gameboard = Array.new(6) { Array.new(7) { ' ' } }
          coords.each do |x, y|
            gameboard[x][y] = stones.rotate![0]
          end
          allow(go.connect4_board).to receive(:xo_array).and_return(gameboard)
          expect(go.winner?).to eql(false)
        end
      end
    end
  end
end
