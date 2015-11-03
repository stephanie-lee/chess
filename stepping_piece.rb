require_relative "Piece.rb"

class SteppingPiece < Piece

  def moves
    directions = get_directions
    possible_moves = []
    directions.each do |direction|
      new_pos = [direction[0] + current_pos[0], direction[1] + current_pos[1]]
      p new_pos
      next if blocking_piece?(new_pos)
      possible_moves << new_pos
    end
    possible_moves
  end

end

class King < SteppingPiece
  DIRECTIONS = [[-1, 1],
              [-1, 0],
              [-1,-1],
              [1,  1],
              [1, -1],
              [1,  0],
              [0,  1],
              [0, -1]]

  def get_directions
    DIRECTIONS
  end
  def to_s
    "K"
  end
end

class Knight < SteppingPiece
  DIRECTIONS = [[-2, 1],
              [-2,-1],
              [2,  1],
              [2, -1],
              [-1, 2],
              [-1, -2],
              [1,  2],
              [1, -2]]
  def get_directions
    DIRECTIONS
  end
  def to_s
    "N"
  end
end
