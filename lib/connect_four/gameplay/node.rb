# frozen_string_literal: true

module Connect4Game
  # node to track gameplay
  class Node
    attr_accessor :token, :parent, :id

    def initialize(parent: nil, token: nil, id: 0)
      @id = id
      @parent = parent
      @token = token
    end
  end
end
