module Minesweeper
  class Board
    def initialize(x, y, num_of_bomb) #, game)
      @x = x
      @y = y
      @num_of_bomb = num_of_bomb
      @cells = []
      initialize_cells
    end

    def initialize_cells
      bombs = []
      (1..@num_of_bomb).map {|e| bombs << true }
      (1..(@x * @y - @num_of_bomb)).map {|e| bombs << false }
      bombs.shuffle!
      index = 0
      (0..(@x - 1)).each do |i|
        row = []
        (0..(@y - 1)).each do |j|
          row << Cell.new(i, j, bombs[index], self)
          puts "#{i}, #{j} has bomb" if bombs[index] == true
          index += 1
        end
        @cells << row
      end
    end

    def show_all_bombs
      @cells.each do |row|
        row.each do |cell|
          cell.show_bombs
        end
      end
    end

    def game=(game)
      @game = game
    end

    def game_over
      @game.over
    end

    def print
      @cells.each do |row|
        puts row.map {|cell| cell.to_s }.join('|')
      end
    end

    def open(i, j)
      if valid_coordinate?(i, j)
        @cells[i][j].open
      else
        puts "invalid coordinate: #{i}, #{j}"
      end
    end

    def toggle_flag(i, j)
      if valid_coordinate?(i, j)
        @cells[i][j].toggle_flag
      else
        puts "invalid coordinate: #{i} ,#{j}"
      end
    end

    def bomb?(i, j)
      if valid_coordinate?(i, j)
        @cells[i][j].bomb?
      else
        # puts "invalid coordinate: #{i}, #{j}"
        false
      end
    end

    def valid_coordinate?(i, j)
      return false if i < 0 or j < 0
      return false if i >= @x or j >= @y
      true
    end
  end
end
