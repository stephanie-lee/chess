class Piece
  attr_accessor :current_pos

  attr_reader :color

  def initialize(pos, board, color)
    @current_pos = pos
    @board = board
    @color = color
  end

  def pos_move?(pos)
    moves.include?(pos)
  end

  def blocking_piece?(new_pos)
    blocking_piece = @board[new_pos]
    if blocking_piece && blocking_piece.color == color
      return true
    end
    false
  end


end


class Pawn < Piece
  # DIRECTIONS = [[1, 0],
  #               [1,1],
  #               [1,-1]



  def to_s
    "P"
  end

end
