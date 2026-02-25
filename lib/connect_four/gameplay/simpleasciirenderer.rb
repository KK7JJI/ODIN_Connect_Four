# frozen_string_literal: true

module Connect4Game
  # code needed to produce ascii display
  class SimplerAsciiRenderer
    attr_reader :last_node

    def render(last_node)
      ascii_state_rep(last_node)
    end

    def ascii_state_rep(last_node)
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
