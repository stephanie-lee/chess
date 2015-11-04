require_relative "display"
require_relative "board"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    while true
      @display.render
      begin
        @display.get_input
      rescue ChessMoveError => e
        @display.render
        puts e.message
        retry
      end
    end
  end


end


g = Game.new
g.play
