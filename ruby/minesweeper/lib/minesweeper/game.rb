module Minesweeper
  class Game
    def self.start
      self.new(8, 8, 10).start
    end

    def initialize(x, y, num_of_bomb)
      @board = Board.new(x, y, num_of_bomb)
      @board.game = self
      @game_over = false
    end

    def over
      @game_over = true
      @board.show_all_bombs
      @board.print
      puts 'Game Over'
    end

    def game_over?
      @game_over
    end

    def start
      while(game_over? != true)
        @board.print
        puts "Input coordinate (separated ',')"
        command, i, j = parse_input
        if command == 'o' # open
          @board.open(i, j)
        elsif command == 'f' # flag
          @board.toggle_flag(i, j)
        end
        # completed?
      end
    end

    def parse_input
      input = gets
      command, i, j = input.split(',')
      puts "#{command}: #{i}, #{j}"
      [command, i.to_i, j.to_i]
    end
  end
end
