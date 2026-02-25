# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    include Connect4Game::Constants
    attr_accessor :players, :game_nodes, :new_player_tokens,
                  :last_node, :token_count

    def initialize(game_name: 'generic game', players: [])
      @game_name = game_name
      @players = players
      @token_count = 0
      @new_player_tokens = []
      @last_node = nil
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
      @token_moves_per_turn = BASE_TOKEN_MOVES_PER_TURN
    end

    def play_round
      reset_gamestate
      until game_over?
        print_gamestate
        players.each do |player|
          add_new_player_tokens(player, @new_tokens_per_turn)
          place_new_tokens(player) unless game_over?
          move_player_tokens(player, @token_moves_per_turn) unless game_over?
          break if game_over?
        end
      end
      print_gamestate
    end

    def reset_gamestate
      self.token_count = 0
      self.new_player_tokens = []
      self.last_node = nil
      players.each do |player|
        player.next_states = []
        player.tokens = []
      end
    end

    def add_new_player_tokens(player, new_token_count)
      new_token_count.times do |_i|
        new_player_tokens << Token.new(token_name: 'stone',
                                       owner: player,
                                       desc: 'game piece')
      end
    end

    def game_over?
      # expecting game specific override
      true
    end

    def player_token_next_states(player)
      player.tokens.each do |token|
        token.next_states = next_states(token)
      end
    end

    def next_states(token)
      # expecting game specific override
      token.next_states = []
      token
    end

    def place_new_tokens(player)
      # expecting game specific override
      while new_player_tokens.length.positive?
        print_gamestate
        token = new_player_tokens.shift
        next_states(token)
        token = player.place_token(token)
        add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def move_player_tokens(player, moves_per_turn)
      # expecting game specific override
      moves_per_turn.times do |_i|
        print_gamestate
        player_token_next_states(player)
        token = player.move_token
        add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def print_gamestate
      # system('clear')
      puts '==================='
      puts render_gamestate_to_ascii
      puts '==================='
    end

    def render_gamestate_to_ascii
      BaseRender.new(node: last_node).ascii_state_rep
    end

    def add_node(node)
      if last_node.is_a?(Node)
        temp = last_node
        self.last_node = node
        last_node.parent = temp
      end
      self.last_node = node unless last_node.is_a?(Node)
    end
  end
end
