# frozen_string_literal: true

module Connect4Game
  # human player
  class Human < Player
    include Connect4Game::Constants
    attr_reader :columns

    def initialize(name: 'Player', icon: '', desc: '',
                   input: UserInput.new)
      super
      @columns = (0...Constants::GAME_COLUMNS).to_a.map do |elem|
        elem.to_s
      end
    end

    def place_token(token)
      # player accepts an object with obj.next_states
      self.next_states = token.next_states.map(&:col)
      selection = next_states.index(user_input)
      token.cur_state = token.next_states[selection]
      tokens << token
      token
    end

    def user_input
      puts "Open columns are: #{next_states.join(', ')}"
      print 'Select column: '
      val = input.get
      until valid_selection?(val)
        puts "Invalid selection, #{val}"
        puts 'Column is full' if columns.include?(val)
        print 'Try again: '
        val = input.get
      end
      val.to_i
    end
  end
end
