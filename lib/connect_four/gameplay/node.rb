# frozen_string_literal: true

module Connect4Game
  # node to track gameplay
  class Node
    attr_accessor :token, :id

    def initialize(token: nil, id: 0)
      @id = id
      @token = token
    end
  end
end
