# frozen_string_literal: true

module Connect4Game
  # setup connect 4 game players
  class C4PlayerSetup < PlayerSetup
    attr_accessor :players

    def run_player_setup
      players = []
      id = 0
      [['Player 1', 'X'], ['Player 2', 'O']].each do |player_name, icon|
        id += 1
        name = choose_player_name(default: player_name)
        player_type_option = config_player_type(player_name: player_name)

        players << Human.new(name: name, icon: icon, id: id) if player_type_option == 1
        players << Random.new(name: name, icon: icon, id: id) if player_type_option == 2
        players << G1.new(name: name, icon: icon, id: id) if player_type_option == 3
      end

      players
    end

    def choose_player_name(default:)
      print "Player name (default #{default}) "
      name = $stdin.gets.chomp
      return default if name.empty?

      name
    end

    def config_player_type(player_name:, default: 1)
      puts "#{player_name} is 1. a human player or 2. a computer player: "
      player_option = 'a'
      until [1, 2].include?(player_option)
        print('enter 1 or 2: ')
        player_option = $stdin.gets.chomp.to_i
        player_option = default if player_option.zero?
      end
      player_option
    end
  end
end
