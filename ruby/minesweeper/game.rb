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

Game.start
