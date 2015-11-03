load "piece.rb"
load "sliding_piece.rb"
load "stepping_piece.rb"

class Board
  attr_accessor :grid

  def initialize(populate = true)
    @grid = Array.new(8) {Array.new(8)}

    create_board if populate
  end

  def create_board
    # add_pawns(:white)
    add_special_pieces(:white)

    add_pawns(:black)
    add_special_pieces(:black)
  end

  def add_special_pieces(color)
    p color
    color == :black ? y_idx = 7 : y_idx = 0
    p color
    [[0,y_idx],[7,y_idx]].each { |pos| self[pos] = Rook.new(pos, self, color)}
    [[1,y_idx],[6,y_idx]].each { |pos| self[pos] = Knight.new(pos, self, color)}
    [[2,y_idx],[5,y_idx]].each { |pos| self[pos] = Bishop.new(pos, self, color)}
    [[3,y_idx]].each { |pos| self[pos] = Queen.new(pos, self, color)}
    [[4,y_idx]].each { |pos| self[pos] = King.new(pos, self, color)}
  end

  def add_pawns(color)
    color == :black ? y_idx = 6 : y_idx = 1
    @grid[y_idx].each_index { |i| self[[i, y_idx]] = Pawn.new([i, y_idx], self, color)} #place pawns
  end

  def [](pos)
    y,x = *pos
    return nil if pos.any? { |el| el<0 || el>7}
    @grid[x][y]
  end

  def []=(pos, value)
    y,x = *pos
    raise "Invalid Position" if pos.any? { |el| el<0 || el>7}
    @grid[x][y] = value
  end

  def move(start, end_pos)
    current_piece = self[start]
    raise "Off board" if !in_bounds?(end_pos)
    raise "No piece at #{start}" if current_piece.nil?
    raise "Piece cannot move to #{end_pos}" unless current_piece.pos_move?(end_pos)

    self[start] = nil
    self[end_pos] = current_piece
    current_piece.current_pos = end_pos
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
          all_empty_or_enemy_spaces << item.current_pos if item.color != color
        end
      end
    end
    all_empty_or_enemy_spaces
  end

end
