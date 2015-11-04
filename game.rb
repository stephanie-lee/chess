require_relative "display"
require_relative "board"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    black_won = false
    white_won = false

    until white_won || black_won
      @display.render
      begin
        @display.get_input
      rescue ChessMoveError => e
        @display.render
        puts e.message
        retry
      end
      black_won = @board.checkmate?(:white)
      white_won = @board.checkmate?(:black)
    end
    @display.render
    puts "Black won!" if black_won
    puts "White won!" if white_won
  end


end


g = Game.new
g.play
