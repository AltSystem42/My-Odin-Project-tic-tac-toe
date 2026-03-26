def tic_tac_toe
  game = Board.new()
  game.showBoard()
  
end

class Board
  attr_accessor :row, :col, :symbol

  def initialize()
    @row = row
    @col = col
    @symbol = symbol
    @grid = [ ["_", "_", "_"],
              ["_", "_", "_"],
              ["_", "_", "_"]]
  end
  def add(symbol, row, col)
    if row >=0 && row <=2
      if col >=0 && col <=2
        @grid[row][col] = symbol 
      else
        p "invalid position"
      end
    else
      p "invalid position"      
    end
  end
  def showBoard()
    @grid.each do |row|
      puts row.map { |cell| cell || " "}.join(" | ")
    end
  end
end

tic_tac_toe()