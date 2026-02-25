# frozen_string_literal: true

module Connect4Game
  # player token locations
  class Connect4TokenState < TokenState
    attr_accessor :id
    attr_reader :row, :col

    def initialize(row: -1, col: -1)
      super(desc: '')
      # token location information
      @row = row
      @col = col
      @id = [row, col].inspect
    end

    def row=(value)
      @row = value
      @id = [value, @col].inspect
    end

    def col=(value)
      @col = value
      @id = [@row, value].inspect
    end
  end
end
