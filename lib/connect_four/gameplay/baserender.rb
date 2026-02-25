# frozen_string_literal: true

module Connect4Game
  # code needed to produce ascii display
  class BaseRender
    attr_reader :last_node

    def initialize(node: nil)
      @last_node = node
    end

    def ascii_state_rep
      return 'no data' if last_node.nil?

      tokens = []
      node = last_node
      while node
        tokens << node.token.token_name
        node = node.parent
      end

      tokens.reverse
    end
  end
end
