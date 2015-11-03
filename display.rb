require 'colorize'
# require_relative 'board.rb'
load 'board.rb'
load 'piece.rb'

class Display
  attr_accessor :cursor

  KEYMAP = {
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\r"   => :return
  }
  MOVES = {
   left: [0, -1],
   right: [0, 1],
   up: [-1, 0],
   down: [1, 0]
 }

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
  end

 def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def handle_key(key)
    case key
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    when :return
      @selected = @selected ? false : true
    end
  end

  def update_pos(diff)
    new_pos = [@cursor[0] + diff[0], @cursor[1] + diff[1]]
    @cursor = new_pos if @board.in_bounds?(new_pos)
    render
  end

  def initialize(board)
    @board = board
    @cursor = [0, 0]
    @selected = false
    #get_input

  end



  def render
    system("clear")
    print "   0    1    2    3    4    5    6    7\n"
    @board.grid.each_with_index do |row, x|
      print "#{x}"
      row.each_with_index do |item, y|
        item_str = ""
        if item.nil?
          item_str = " [ ] "
        else
          item_str = " [#{item}] "
        end
        if @cursor == [x, y]
          print item_str.red
        else
          white = (x + y).even?
          if white
            print item_str.blue
          else
            print item_str.yellow
          end
        end
      end
      print "\n"
    end
  end
end


b = Board.new
d = Display.new(b)
d.render
