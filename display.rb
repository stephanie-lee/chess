require 'colorize'

require_relative 'cursorable.rb'
require_relative 'board.rb'
require_relative 'piece.rb'

class Display
  include Cursorable
  attr_accessor :cursor


  def initialize(board)
    @board = board
    @cursor = [0, 0]
    @selected = false
    @selected_piece = nil
    render
    #get_input
  end


  def render
    system("clear")
    print "  0 1 2 3 4 5 6 7\n"
    @board.grid.each_with_index do |row, y|
      print "#{y}"
      row.each_with_index do |item, x|
        item_str = "   "
        if item.nil?
          item_str = "  "
        else
          item_str = " #{item}"
        end
        print item_str.colorize(color_options(x,y))
      end
      print "\n"
    end
  end
end


def color_options(x,y)
  txt = :black
  current_piece = @board[[x,y]]
  if current_piece && current_piece.color == :white
    txt = :white
  end

  if @cursor == [x, y]
     bg = :yellow
  else
    white_tile = (x + y).even?
    if white_tile
      bg = :blue
    else
      bg = :red
    end
  end

  if @selected_piece == [x, y]
    bg = :green
  end

  { background: bg, color: txt }
end


b = Board.new
# b.move([3,0],[3,6])
# b.move([3,6],[3,5])
# #b.move([3,0],[6,3])
d = Display.new(b)
#
# black_pawn = b[[2,6]]
d.render
#  black_pawn.moves
# #d.render
#
# #p b
# # piece = b[[0,0]]
#
#
# #my_blocker = King.new([5,0],b,:white)
# #b[[5,0]] = my_blocker
