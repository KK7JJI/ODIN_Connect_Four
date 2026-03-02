# frozen_string_literal: true

module Connect4Game
  include Constants

  # Coordination for the connect 4 game.
  class PlaceTokens
    attr_accessor :node_manager, :new_tokens_per_turn

    def initialize(node_manager: nil)
      @node_manager = node_manager
      @new_tokens_per_turn = BASE_NEW_TOKENS_PER_TURN
    end

    # inputs:
    #  player
    #
    # returns:
    #
    # add_node is in GamePlay class
    # request_next_states is in GamePlay class
    #
    # This communicates with Players, GamePlay,
    # The connect 4 version will also communicate with
    # Board
    #
    def place_new_tokens(player:)
      new_player_tokens = new_player_tokens(player: player)
      while new_player_tokens.length.positive?
        token = new_player_tokens.shift
        request_next_states(token)
        token = place_token(player: player, token: token)
        node_manager.add_node(Node.new(parent: nil, token: token))
        break if game_over?
      end
    end

    def new_player_tokens(player:)
      Array.new(@new_tokens_per_turn) do
        Token.new(token_name: 'stone', owner: player, desc: 'game piece')
      end
    end

    def place_token(player:, token:)
      player.place_token(token)
    end
  end
end
