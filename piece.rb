class Piece
  attr_accessor :current_pos

  attr_reader :color

  def initialize(pos, board, color)
    @current_pos = pos
    @board = board
    @color = color
  end

  def inspect
    "Pawn"
  end

  def to_s
    "P"
  end

  def pos_move?(pos)
    moves.include?(pos)
  end


end


class Pawn < Piece
  def to_s
    "P"
  end
end
