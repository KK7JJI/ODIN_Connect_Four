# frozen_string_literal: true

module Connect4Game
  # setup connect 4 game players
  class PlayerSetup
    attr_accessor :players

    def initialize
      @players = []
    end

    def run_player_setup
      [['Player 1', 'X'], ['Player 2', 'O']].each do |player, icon|
        print "Player name (default #{player})"
        name = $stdin.gets.chomp

        puts "#{name} is 1. a human player or 2. a computer player: "
        player_option = 'a'
        until [1, 2].includes?(player_option)
          print('enter 1 or 2:')
          player_option = $stdin.gets.chomp.to_i
        end

        players << Human.new(name: name, icon: icon) if player_option == 1
        players << Random.new(name: name, icon: icon) if player_option == 2
      end
      players
    end
  end
end
