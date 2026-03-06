# frozen_string_literal: true

module Connect4Game
  # define user input method
  class UserInput
    def get
      $stdin.getch
    end
  end
end
