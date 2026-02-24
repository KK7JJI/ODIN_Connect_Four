# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class GamePlay
    attr_accessor :players, :game_nodes, :new_player_tokens,
                  :last_node, :token_count

    NEW_TOKENS_PER_TURN = 1
    TOKEN_MOVES_PER_TURN = 1

    def initialize(game_name: 'generic game', players: [])
      @game_name = game_name
      @players = players
      @token_count = 0
      @new_player_tokens = []
      @last_node = nil
    end

    def play_round
      reset_gamestate
      until game_over?
        players.each do |player|
          add_new_player_tokens(player)
          place_new_tokens(player) unless game_over?
          move_player_tokens(player) unless game_over?
          break if game_over?
        end
      end
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

    def add_new_player_tokens(player)
      NEW_TOKENS_PER_TURN.times do |_i|
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
        token = new_player_tokens.shift
        next_states(token)
        token = player.place_token(token)
        add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def move_player_tokens(player)
      # expecting game specific override
      TOKEN_MOVES_PER_TURN.times do |_i|
        player_token_next_states(player)
        token = player.move_token
        add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def walk_nodes
      tokens = []
      node = last_node

      while node
        tokens << node.token.token_name
        node = node.parent
      end

      tokens.reverse
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

  # describes the generic game player token
  class Token
    attr_accessor :next_states, :cur_state, :owner, :token_name, :desc

    def initialize(token_name: '', owner: nil, desc: '',
                   cur_state: nil, next_states: [])
      @token_name = token_name
      @owner = owner
      @desc = desc
      @cur_state = cur_state
      @next_states = next_states
    end
  end

  # describes the token's state (i.e. location) in the current game.
  class TokenState
    def initialize(desc: '')
      @desc = desc
    end
  end

  # node to track gameplay
  class Node
    attr_accessor :token, :parent

    def initialize(parent: nil, token: nil)
      @parent = parent
      @token = token
    end
  end
end
