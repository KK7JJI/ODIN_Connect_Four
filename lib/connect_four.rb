# frozen_string_literal: true

require 'debug'
require 'json'
require 'io/console'
require_relative 'connect_four/save_game'
require_relative 'connect_four/load_game'
require_relative 'connect_four/constants'
require_relative 'connect_four/c4constants'
require_relative 'connect_four/app'
require_relative 'connect_four/player'
require_relative 'connect_four/player/human'
require_relative 'connect_four/player/random'
require_relative 'connect_four/player/g1'
require_relative 'connect_four/player/g1/g1scoring'
require_relative 'connect_four/player/userinput'
require_relative 'connect_four/gameplay'
require_relative 'connect_four/gameplay/playersetup'
require_relative 'connect_four/gameplay/token'
require_relative 'connect_four/gameplay/tokenstate'
require_relative 'connect_four/gameplay/placetokens'
require_relative 'connect_four/gameplay/movetokens'
require_relative 'connect_four/gameplay/simpleasciirenderer'
require_relative 'connect_four/gameplay/nextstates'
require_relative 'connect_four/gameplay/node'
require_relative 'connect_four/gameplay/nodemanager'
require_relative 'connect_four/gameplay/gameover'
require_relative 'connect_four/connect4play'
require_relative 'connect_four/connect4play/c4renderer'
require_relative 'connect_four/connect4play/connect4tokenstate'
require_relative 'connect_four/connect4play/c4gameover'
require_relative 'connect_four/connect4play/c4gameover/rowmatch'
require_relative 'connect_four/connect4play/c4gameover/colmatch'
require_relative 'connect_four/connect4play/c4gameover/diagmatch'
require_relative 'connect_four/connect4play/c4nextstates'
require_relative 'connect_four/connect4play/c4gameboard'
require_relative 'connect_four/connect4play/c4placetokens'
require_relative 'connect_four/connect4play/c4playersetup'

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
