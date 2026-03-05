# frozen_string_literal: true

# lib/my_project/app.rb
module Connect4Game
  # entry point for the Bash script executable.
  class App
    def run(args)
      game = Connect4Game::Connect4play.new
      game.play_round(on_state_change: ->(state) { puts state },
                      flush_display: -> { print "\e[2J\e[f" })
    end
  end
end
