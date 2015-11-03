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



end

class SlidingPiece < Piece
  def pos_move?(new_pos)
  end

  def moves
  end
end

class SteppingPiece < Piece
  def pos_move?(new_pos)
  end

  def moves
    directions = get_directions
    possible_moves = directions.map do |pos|
      [pos[0] + current_pos[0],
      pos[1] + current_pos[1]]
    end

    possible_moves.select! {|pos| @board.in_bounds?(pos)}
    #  all_empty_enemy_spaces.select |pos|
    #   if possible_moves.include?(pos)

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
    "Kn"
  end
end

class Pawn < Piece
  def to_s
    "P"
  end
end

class Bishop < SlidingPiece
  def to_s
    "B"
  end
end

class Rook < SlidingPiece
  def to_s
    "R"
  end
end

class Queen < SlidingPiece
  def to_s
    "Q"
  end
end
