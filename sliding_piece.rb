require_relative "Piece.rb"

class SlidingPiece < Piece
  def moves
    directions = get_directions
    possible_moves = []
    all_available_spaces = @board.all_empty_enemy_spaces(@color)
    directions.each do |direction|
      new_pos = @current_pos

      while @board.in_bounds?(new_pos)
        new_pos = [direction[0] + new_pos[0], direction[1] + new_pos[1]]
        blocking_piece = @board[new_pos]
        p "new_pos #{new_pos}, blocking_piece #{blocking_piece}"
        if blocking_piece.nil?
          break unless @board.in_bounds?(new_pos)
          possible_moves << new_pos
        elsif blocking_piece.color == self.color
          break
        else
          possible_moves << new_pos
          break
        end

      end

    end
    possible_moves
  end

end

# def moves
#   directions = get_directions
#   possible_moves = directions.map do |pos|
#     [pos[0] + current_pos[0],
#     pos[1] + current_pos[1]]
#   end
#   all_available_spaces = @board.all_empty_enemy_spaces(@color)
#   all_available_spaces & possible_moves
# end


class Bishop < SlidingPiece
  DIRECTIONS = [[-1, -1],
                [ 1, 1],
                [-1, 1],
                [1, -1]]
  def to_s
    "B"
  end
  def get_directions
    DIRECTIONS
  end
end

class Rook < SlidingPiece
  DIRECTIONS = [[0, -1],
                [ 0, 1],
                [-1, 0],
                [1, 0]]
  def to_s
    "R"
  end
  def get_directions
    DIRECTIONS
  end
end

class Queen < SlidingPiece
  DIRECTIONS = [[0, -1],
                [ 0, 1],
                [-1, 0],
                [1,  0],
                [-1,-1],
                [ 1, 1],
                [-1, 1],
                [1, -1]]
  def to_s
    "Q"
  end
  def get_directions
    DIRECTIONS
  end
end
