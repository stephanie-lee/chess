require_relative "Piece.rb"

class SteppingPiece < Piece
  def pos_move?(new_pos)
  end

  def moves
    directions = get_directions
    possible_moves = directions.map do |direction|
      [direction[0] + current_pos[0],
      direction[1] + current_pos[1]]
    end
    all_available_spaces = @board.all_empty_enemy_spaces(@color)
    all_available_spaces & possible_moves
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
