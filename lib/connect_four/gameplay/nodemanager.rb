# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class NodeManager
    include Connect4Game::SaveGame

    attr_accessor :node_count
    attr_reader :all_nodes, :all_tokens

    def initialize
      @all_nodes = []
      @all_tokens = []
    end

    def add_node(token:)
      node = Node.new(token: token, id: node_count)
      all_nodes << node
      node
    end

    def last_node
      all_nodes[-1]
    end

    def game_nodes
      all_nodes
    end

    def played_tokens
      all_nodes.map(&:token)
    end

    def self.json_create(hash)
      obj = allocate
      obj.json_create(allocate, hash)
    end
  end
end
