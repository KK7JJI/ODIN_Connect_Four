# frozen_string_literal: true

require_relative 'connect_four/app'
require_relative 'connect_four/constants'
require_relative 'connect_four/player'
require_relative 'connect_four/gameplay'
require_relative 'connect_four/gameplay/playersetup'
require_relative 'connect_four/gameplay/token'
require_relative 'connect_four/gameplay/tokenstate'
require_relative 'connect_four/gameplay/simpleasciirenderer'
require_relative 'connect_four/gameplay/node'
require_relative 'connect_four/connect4play'
require_relative 'connect_four/connect4play/c4asciirenderer'
require_relative 'connect_four/connect4play/connect4tokenstate'

# Entry point.  run.sh starts execution
# of the program here.
module Connect4Game
  def self.run(args)
    puts "File: #{__FILE__.split('/')[-1]}, Running method: #{__method__}"
    app = App.new
    app.run(args)
  end
end

# Start the program if this file is executed directly
Connect4Game.run(ARGV)
