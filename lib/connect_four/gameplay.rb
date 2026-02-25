# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    include Connect4Game::Constants
    attr_accessor :players, :last_node

    def initialize(game_name: 'generic game',
                   players: nil,
                   renderer: SimpleAsciiRenderer.new)
      @game_name = game_name
      @players = players || []
      @last_node = nil
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = BASE_TOKEN_MOVES_PER_TURN
      @renderer = renderer
    end

    def play_round(on_state_change: nil)
      setup_new_game
      on_state_change&.call(render_gamestate)
      until game_over?
        players.each do |player|
          player_turn(player: player)
          break if game_over?

          on_state_change&.call(render_gamestate)
        end
      end
      on_state_change&.call(render_gamestate)
    end

    def player_turn(player:)
      puts player.name
      place_new_tokens(player: player) if !game_over? && supports_new_tokens?
      move_player_tokens(player: player) if !game_over? && supports_token_movement?
    end

    def supports_new_tokens?
      @new_tokens_per_turn.positive?
    end

    def supports_token_movement?
      @token_moves_per_turn.positive?
    end

    def setup_new_game
      self.players = PlayerSetup.new.run_player_setup
    end

    def place_new_tokens(player:)
      new_player_tokens = add_new_player_tokens(player: player)
      while new_player_tokens.length.positive?
        token = new_player_tokens.shift
        place_token(player: player, token: token)
        break if game_over?
      end
    end

    def add_new_player_tokens(player:)
      Array.new(@new_tokens_per_turn) do
        Token.new(token_name: 'stone', owner: player, desc: 'game piece')
      end
    end

    def place_token(player:, token:)
      compute_next_states(token)
      token = player.place_token(token)
      add_node(Node.new(parent: nil, token: token))
    end

    def move_player_tokens(player:)
      @token_moves_per_turn.times do
        player_token_next_states(player)
        token = player.move_token
        add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def game_over?
      raise NotImplementedError, 'game_over? must be implimented in a subclass.'
    end

    def player_token_next_states(player)
      player.tokens.each do |token|
        token.next_states = compute_next_states(token)
      end
    end

    def compute_next_states(token)
      # expecting game specific override
      token.next_states = []
      token
    end

    def render_gamestate
      @renderer.render(last_node)
    end

    def add_node(node)
      node.parent = last_node
      self.last_node = node
    end
  end
end
