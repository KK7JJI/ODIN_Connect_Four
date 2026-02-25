# frozen_string_literal: true

# lib/my_project/app.rb
module Connect4Game
  # entry point for the Bash script executable.
  class App
    def run(args)
      # puts "::App.run Running with arguments: #{args.inspect}"
      game = connect4play.new
    end
  end
end
