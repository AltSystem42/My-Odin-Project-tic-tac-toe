require "io/console"

def tic_tac_toe
  game = Board.new
  puts
  game.show_board_with_selector
  puts
  game.play_game
end

def winner?(grid)
  winning_lines = [
  [[0,0],[0,1],[0,2]], # top row
  [[1,0],[1,1],[1,2]], # middle row
  [[2,0],[2,1],[2,2]], # bottom row
  [[0,0],[1,0],[2,0]], # left column
  [[0,1],[1,1],[2,1]], # middle column
  [[0,2],[1,2],[2,2]], # right column
  [[0,0],[1,1],[2,2]], # diagonal \
  [[0,2],[1,1],[2,0]]  # diagonal /
  ]
  winning_lines.each do |line|
  values = line.map { |row, col| grid[row][col] }
  return true if values.uniq.length == 1 && values[0] != "_"
  end
  false
end

# Represents a tic-tac-toe board and allows moves to be placed
class Board
  attr_accessor :row, :col, :symbol, :selector_row, :selector_col

  def initialize
    @row = row
    @col = col
    @symbol = symbol
    @selector_row = 1
    @selector_col = 1
    @turn = 0
    @grid = [%w[_ _ _],
             %w[_ _ _],
             %w[_ _ _]]
  end

  def add(symbol, row, col)
    if row.between?(0, 2)
      if col.between?(0, 2)
        @grid[row][col] = symbol
      else
        p "invalid position"
      end
    else
      p "invalid position"
    end
  end

  def show_board
    @grid.each do |row|
      puts row.map { |cell| cell || " " }.join(" | ")
    end
  end

  def play_game
    loop do
      input = read_input
      break if input == "q"

      selector(input)
      select_input(input)
      puts
      if @turn == 9 || winner?(@grid)
        show_board
        break
      end
    end
  end

  def show_board_with_selector
    @grid.each_with_index do |row, r|
      line = row.each_with_index.map do |cell, c|
        if r == @selector_row && c == @selector_col
          "-"
        else
          cell
        end
      end
      puts line.join(" | ")
    end
  end

  def selector(input)
    case input
    when "\e[A" then move_up # Up
    when "\e[B" then move_down # Down
    when "\e[C" then move_right # Right
    when "\e[D" then move_left # Left
    end
    show_board_with_selector
  end

  def move_up
    @selector_row -= 1 if @selector_row.positive?
  end

  def move_down
    @selector_row += 1 if @selector_row < 2
  end

  def move_right
    @selector_col += 1 if @selector_col < 2
  end

  def move_left
    @selector_col -= 1 if @selector_col.positive?
  end

  def select_input(input)
    if input == "o"
      @turn.even? ? pressed("O") : p("X's turn")
    elsif input == "x"
      @turn.odd? ? pressed("X") : p("O's turn")
    end
  end

  def pressed(placeholder)
    if empty?(@selector_row, @selector_col)
      add(placeholder, @selector_row, @selector_col)
      @turn += 1
    else
      p "invalid move"
    end
  end

  def empty?(row, col)
    return true if @grid[row][col] == "_"

    false
  end

  def read_input
    key = $stdin.getch        

    if key == "\e"            
      key << $stdin.getch     
      key << $stdin.getch     
    end

    key 
  end
end

tic_tac_toe
