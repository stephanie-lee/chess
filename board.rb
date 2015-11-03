load "piece.rb"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}

    create_board
    # @grid[6].each_index { |i| @grid[6][i] = Piece.new} #place pawns
    #
    # @grid[0].each_index { |i| @grid[1][i] = Piece.new} #change!
    # @grid[7].each_index { |i| @grid[6][i] = Piece.new} #change!
  end

  def create_board
    @grid[1].each_index { |i| self[[1,i]] = Pawn.new([1, i], self, :black)} #place pawns
    [[0,0],[0,7]].each { |pos| self[pos] = Rook.new(pos, self, :black)}
    [[0,1],[0,6]].each { |pos| self[pos] = Knight.new(pos, self, :black)}
    [[0,2],[0,5]].each { |pos| self[pos] = Bishop.new(pos, self, :black)}
    [[0,3]].each { |pos| self[pos] = Queen.new(pos, self, :black)}
    [[0,4]].each { |pos| self[pos] = King.new(pos, self, :black)}

    @grid[6].each_index { |i| self[[6,i]] = Pawn.new([6, i], self, :white)} #place pawns
    [[7,0],[7,7]].each { |pos| self[pos] = Rook.new(pos, self, :white)}
    [[7,1],[7,6]].each { |pos| self[pos] = Knight.new(pos, self, :white)}
    [[7,2],[7,5]].each { |pos| self[pos] = Bishop.new(pos, self, :white)}
    [[7,3]].each { |pos| self[pos] = Queen.new(pos, self, :white)}
    [[7,4]].each { |pos| self[pos] = King.new(pos, self, :white)}
  end

  def [](pos)
    x,y = *pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = *pos
    @grid[x][y] = value
  end

  def move(start, end_pos)
    current_piece = self[start]
    raise "No piece at #{start}" if current_piece.nil?
    raise "Piece cannot move to #{end_pos}" unless current_piece.pos_move?(end_pos)

    self[start] = nil
    self[end_pos] = current_piece
    current_piece.pos = end_pos
  end

  def in_bounds?(pos)
    pos.all? { |cord| cord>=0 && cord<=7 }
  end

  def all_empty_enemy_spaces(color)
    all_empty_or_enemy_spaces = []
    @grid.each_with_index do |row, x|
      row.each_with_index do |item, y|
        if item.nil?
          all_empty_or_enemy_spaces << [x, y]
        else
          p item.color
          all_empty_or_enemy_spaces << item.current_pos if item.color != color
        end
      end
    end
    all_empty_or_enemy_spaces
  end

end
