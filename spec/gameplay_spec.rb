# frozen_string_literal: true

require_relative '../lib/connect_four/gameplay/nextstates'
require_relative '../lib/connect_four/gameplay/nodemanager'
require_relative '../lib/connect_four/gameplay/node'

describe Connect4Game::GamePlay do
  player1 = Connect4Game::Human.new(name: 'Player 1', icon: 'X')
  player2 = Connect4Game::Human.new(name: 'Player 2', icon: 'O')
  players = [player1, player2]
  let(:gameover) { Connect4Game::GameOver.new }

  subject(:gp) do
    described_class.new(
      players: players
    )
  end

  def new_token(player, name)
    Connect4Game::Token.new(
      player_id: player.id,
      icon: player.icon,
      token_name: name,
      desc: 'game piece',
      cur_state: Connect4Game::TokenState.new
    )
  end

  describe '#play round' do
    let(:token1) { new_token(player1, 'stone1') }
    let(:token2) { new_token(player1, 'stone2') }
    let(:token3) { new_token(player2, 'stone3') }
    let(:token4) { new_token(player2, 'stone4') }
    let(:token5) { new_token(player1, 'stone5') }

    before do
      allow(player1).to receive(:place_token).and_return(token1, token5)
      allow(player1).to receive(:move_token).and_return(token2)
      allow(player2).to receive(:place_token).and_return(token3)
      allow(player2).to receive(:move_token).and_return(token4)
      allow(gp).to receive(:setup_new_game)
      allow(gp).to receive(:reinitialize)
      allow(gp.gameover).to receive(:game_over?)
      allow(gp.gameover).to receive(:winner?)
      allow(gp.gameover).to receive(:winner)
      allow(gp.gameover).to receive(:draw?)
      allow(gp.nextstates).to receive(:request_next_states).and_return([])
    end

    it 'play ends with player2 move' do
      sequence = [false] + [false] * 5 + [false] * 5 + [true] + [true]
      allow(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token4)
    end

    it 'play ends with player1 first placed_token' do
      sequence = [false] * 2 + [true] * 3 + [true] + [true]
      expect(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token1)
    end

    it 'play ends with player1 first move_token' do
      sequence = [false] * 4 + [true] * 2 + [true] + [true]
      expect(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token2)
    end

    it 'play ends with player2 first place_token' do
      sequence = [false] + [false] * 5 + [false] + [true] * 4 + [true]
      expect(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token3)
    end

    it 'play ends with player2 first move_token' do
      sequence = [false] + [false] * 5 + [false] * 3 + [true] * 3 + [true]
      expect(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token4)
    end

    it 'play ends with player1 second place_token' do
      sequence = [false] + [false] * 5 + [false] * 5 + [false] + [false] + [true] * 5
      expect(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.node_manager.last_node.token).to eql(token5)
    end
  end
  describe '#print_gamestate' do
    let(:token1) { new_token(player1, 'stone1') }
    let(:token2) { new_token(player1, 'stone2') }
    let(:token3) { new_token(player2, 'stone3') }
    let(:token4) { new_token(player2, 'stone4') }
    let(:token5) { new_token(player1, 'stone5') }

    before do
      allow(player1).to receive(:place_token).and_return(token1, token5)
      allow(player1).to receive(:move_token).and_return(token2)
      allow(player2).to receive(:place_token).and_return(token3)
      allow(player2).to receive(:move_token).and_return(token4)
      allow(gp).to receive(:setup_new_game)
      allow(gp).to receive(:reinitialize)
      allow(gp.gameover).to receive(:winner?)
      allow(gp.gameover).to receive(:winner)
      allow(gp.gameover).to receive(:game_over?)
      allow(gp.gameover).to receive(:draw?)
    end

    it 'printed output is produced' do
      sequence = [false] + [false] * 5 + [false] * 5 + [false] + [false] + [true] * 5
      allow(gp.gameover).to receive(:game_over?).and_return(*sequence)
      gp.play_round(on_state_change: ->(gamestate) { gamestate })
      expect(gp.render_gamestate).to eql(
        %w[stone1 stone2 stone3 stone4 stone5]
      )
    end
  end
end
