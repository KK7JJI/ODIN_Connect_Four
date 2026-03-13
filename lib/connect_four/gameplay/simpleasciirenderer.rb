# frozen_string_literal: true

module Connect4Game
  # code needed to produce ascii display
  class SimpleAsciiRenderer
    def render(nodes)
      ascii_state_rep(nodes)
    end

    def ascii_state_rep(nodes)
      return 'no data' if nodes.empty?

      tokens = []
      nodes.each do |node|
        tokens << node.token.token_name
      end

      tokens
    end
  end
end
