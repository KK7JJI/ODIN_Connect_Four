# frozen_string_literal: true

module Connect4Game
  # define user input method
  class UserInput
    include Connect4Game::SaveGame

    def get
      $stdin.gets.chomp
    end
  end
end
