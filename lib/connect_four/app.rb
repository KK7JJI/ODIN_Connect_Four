# frozen_string_literal: true

# lib/my_project/app.rb
module Connect4Game
  # entry point for the Bash script executable.
  class App
    include Connect4Game::Constants
    include Connect4Game::LoadGame

    def run(args)
      fname = select_save_file
      if fname.empty?
        game = Connect4Game::Connect4play.new
      else
        game = JSON.load(File.read(fname))
        delete_save_file(fname)
      end
      game.play_round(on_state_change: ->(state) { puts state },
                      flush_display: -> { print CLS })
    end
  end
end
