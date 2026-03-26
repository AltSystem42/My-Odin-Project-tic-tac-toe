require 'io/console'

def tic_tac_toe
  game = Board.new
  game.show_board
  game.play_game
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
    puts
    @grid.each do |row|
      puts row.map { |cell| cell || " " }.join(" | ")
    end
  end

  def play_game
    loop do
      input = STDIN.getch

      if input == "\e"
        input << STDIN.getch
        input << STDIN.getch
      end
      case input
      when "\e[A" # Up
        @selector_row -= 1 if @selector_row > 0
        show_board_with_selector
      when "\e[B" # Down
        @selector_row += 1 if @selector_row < 2
        show_board_with_selector
      when "\e[C" # Right
        @selector_col += 1 if @selector_col < 2
        show_board_with_selector
      when "\e[D" # Left
        @selector_col -= 1 if @selector_col > 0
        show_board_with_selector
      when "o" #O is pressed
        if @grid[@selector_row][@selector_col] != "_"
          p "invalid move"
        else
          add("o", @selector_row, @selector_col)
        end
        show_board
      when "x" #X is pressed
        if @grid[@selector_row][@selector_col] != "_"
          p "invalid move"
        else
          add("x", @selector_row, @selector_col)
        end
        show_board
      when "q"
        break
      else
        p "invalid key pressed"
      end
    end
  end
  def show_board_with_selector
    puts
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
end

tic_tac_toe
