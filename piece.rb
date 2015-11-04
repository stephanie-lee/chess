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

  def enemy_piece?(new_pos)
    blocking_piece = @board[new_pos]
    if blocking_piece && blocking_piece.color != color
      return true
    end
    false
  end
  def inspect
    self.class
  end
end


class Pawn < Piece
  FORWARD_DIRECTIONS = [[0,  1],
                        [0,  2]]
  KILL_DIRECTIONS = [[-1, 1],
                    [1,  1]]
  def initialize(pos, board, color)
    @first_move = true
    super
  end

  def get_directions
    if color == :black
      forward_directions = FORWARD_DIRECTIONS.map { |el| [el[0] * -1, el[1] * -1]}
      kill_directions = KILL_DIRECTIONS.map { |el| [el[0] * -1, el[1] * -1]}
    else
      forward_directions = FORWARD_DIRECTIONS
      kill_directions = KILL_DIRECTIONS
    end
    [forward_directions, kill_directions]
  end


  def moves
    possible_moves = []

    forward_directions, kill_directions = get_directions

    forward_directions.each do |f_dir|
      new_pos = [f_dir[0] + @current_pos[0],
                 f_dir[1] + @current_pos[1]]
      break if blocking_piece?(new_pos)
      possible_moves << new_pos
      break unless @first_move
    end

    kill_directions.each do |k_dir|
      new_pos = [k_dir[0] + @current_pos[0],
                 k_dir[1] + @current_pos[1]]
      if enemy_piece?(new_pos)
        possible_moves << new_pos
      end
    end

    possible_moves
  end

  def to_s
    "P"
  end

end
