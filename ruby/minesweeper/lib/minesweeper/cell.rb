module Minesweeper
  class Cell
    def initialize(x, y, bomb, board)
      @x = x
      @y = y
      @board = board
      @bomb = bomb
      @flag = false
      @opened = false
      @num_neighbor_boms_counted = false
      @show_bombs = false
    end

    def to_s
      if opened?
        num_neighbor_boms
      else
        if flag?
          'F'
        elsif bomb? && show_bombs?
          'B'
        else
          ' '
        end
      end
    end

    def show_bombs?
      @show_bombs
    end

    def show_bombs
      @show_bombs = true
    end

    def bomb?
      @bomb
    end

    def flag?
      @flag
    end

    def toggle_flag
      if opened?
        puts "this cell is already opened"
      else
        @flag = !(@flag)
      end
    end

    def opened?
      @opened
    end

    def open
      if opened?
        puts "this cell is already opened"
      else
        if bomb?
          @board.game_over
        else
          @opened = true
        end
      end
    end

    def num_neighbor_boms
      if @num_neighbor_boms_counted
        @num_neighbor_boms
      else
        num = 0
        num += 1 if @board.bomb?(@x - 1, @y - 1)
        num += 1 if @board.bomb?(@x    , @y - 1)
        num += 1 if @board.bomb?(@x + 1, @y - 1)
        num += 1 if @board.bomb?(@x - 1, @y)
        # x, y is self
        num += 1 if @board.bomb?(@x + 1, @y)
        num += 1 if @board.bomb?(@x - 1, @y + 1)
        num += 1 if @board.bomb?(@x    , @y + 1)
        num += 1 if @board.bomb?(@x + 1, @y + 1)
        @num_neighbor_boms_counted = true
        @num_neighbor_boms = num
        @num_neighbor_boms
      end
    end
  end
end
