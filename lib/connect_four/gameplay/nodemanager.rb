# frozen_string_literal: true

module Connect4Game
  # Coordination for the connect 4 game.
  class NodeManager
    attr_accessor :last_node
    attr_reader :all_nodes, :all_tokens

    def initialize(last_node: nil)
      @last_node = last_node
      @all_nodes = []
      @all_tokens = []
    end

    def add_node(token:)
      node = Node.new(parent: nil, token: token)
      node.parent = last_node
      self.last_node = node
      node
    end

    def game_nodes(node: last_node)
      @all_nodes = traverse_nodes(node)
    end

    def played_tokens(node: last_node)
      traverse_nodes(node).map(&:token)
    end

    private

    def traverse_nodes(node)
      return [node] if node.parent.nil?

      nodes = traverse_nodes(node.parent)
      nodes << node
    end
  end
end
