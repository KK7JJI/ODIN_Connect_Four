# frozen_string_literal: true

module Connect4Game
  # node to track gameplay
  class Node
    include Connect4Game::SaveGame
    attr_accessor :token, :parent

    def initialize(parent: nil, token: nil)
      @parent = parent
      @token = token
    end
  end
end
