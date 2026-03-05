# frozen_string_literal: true

module Hangman
  # identify and select savegame files
  module LoadGame
    def select_save_file
      save_files = hm_file_array
      return '' if save_files.empty?

      save_file_msg(save_files)
      user_selection(save_files)
    end

    def hm_file_array
      file_list = Dir.children(Dir.pwd)
      file_list.filter { |name| name.include?('.c4') }
    end

    def user_selection(save_files)
      print 'Select file (press enter for new game): '
      response = $stdin.gets.chomp
      return response if response == ''

      until response.to_i.positive? && response.to_i <= save_files.length
        print 'Invalid response, try again: '
        puts "response #{response}, #{response.to_i}"
        response = $stdin.gets.chomp
        return '' if response.empty?
      end
      save_files[response.to_i - 1]
    end

    def save_file_msg(save_files)
      puts 'Saved games'
      puts '----------------------------'
      save_files.each_with_index { |name, idx| puts "#{idx + 1}, #{name}" }
      puts '----------------------------'
    end

    def delete_save_file(fname)
      return false unless File.exist?(fname)
      return false unless File.file?(fname)

      File.delete(fname)
      true
    end
  end
end
