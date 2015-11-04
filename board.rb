require_relative "piece.rb"
require_relative "sliding_piece.rb"
require_relative "stepping_piece.rb"
require_relative "display.rb"

class Board
  attr_accessor :grid

  def initialize(populate = true)
    @grid = Array.new(8) {Array.new(8)}

    create_board if populate
  end

  def create_board
    # consider [:white, :black]
    # add_pawns(:white)
    add_special_pieces(:white)

    # add_pawns(:black)
    add_special_pieces(:black)
  end

  def add_special_pieces(color)
    # consider array of pieces
    color == :black ? y_idx = 7 : y_idx = 0
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
    y, x = pos
    return nil if pos.any? { |el| el < 0 || el > 7}
    @grid[x][y]
  end

  def []=(pos, value)
    y,x = pos
    raise "Invalid Position" if pos.any? { |el| el < 0 || el > 7}
    @grid[x][y] = value
  end

  def move(start, end_pos)
    current_piece = self[start]
    raise_move_errors(start, end_pos)
    position_change(start, end_pos)
  end

  def raise_move_errors(start, end_pos)
    raise ChessMoveError, "Off board" if !in_bounds?(end_pos)
    raise ChessMoveError, "No piece at #{start}" if self[start].nil?
    raise ChessMoveError, "Piece cannot move to #{end_pos}" unless self[start].pos_move?(end_pos)
    raise ChessMoveError, "That move puts you in check." if put_self_in_check?(start, end_pos)
  end

  def position_change(start, end_pos)
    current_piece = self[start]
    self[start] = nil
    self[end_pos] = current_piece
    current_piece.current_pos = end_pos
  end

  def in_bounds?(pos)
    pos.all? { |cord| cord >= 0 && cord <= 7 }
  end

  def dup
    board_dup = Board.new(false)

    @grid.each_with_index do |row, y|
      row.each_with_index do |item, x|
        if item
          board_dup[[x, y]] = (item.class).new([x, y], board_dup, item.color)
        end
      end
    end
    board_dup
  end

  def move!(start, end_pos)
    board_dup = self.dup
    board_dup.position_change(start, end_pos) if board_dup.in_bounds?(end_pos)
    board_dup
  end

  def put_self_in_check?(start, end_pos)
    board_dup = self.move!(start, end_pos)
    our_color = self[start].color
    our_king_pos = find_king(board_dup, our_color)
    return true if checking_piece?(board_dup, our_king_pos)
    false
  end

  def in_check?(our_color)
    our_king_pos = find_king(self, our_color)
    enemy_color = (our_color == :black ? :white : :black)
    king_killer_piece = find_piece{ |piece| piece.color == enemy_color && piece.moves.include?(our_king_pos)}
    return true if king_killer_piece
    false
  end

  def checkmate?(our_color)
    self.grid.flatten.each do |piece|
      if piece
        next if piece.color != our_color
        moves = piece.moves
        moves.each do |pos|
          dup_board = move!(piece.current_pos, pos)
          return false unless dup_board.in_check?(our_color)
        end
      end
    end
    true
  end

  def find_piece(&blk)
    self.grid.flatten.each do |piece|
      if piece
        return piece if blk.call(piece)
      end
    end
    nil
  end

  def checking_piece?(board, our_king_pos)
    our_color = board[our_king_pos].color
    board.grid.flatten.each do |piece|
      if piece
        if piece.color != our_color && piece.moves.include?(our_king_pos)
          return piece
        end
      end
    end
    nil
  end

  def find_king(board, our_color)
    board.grid.flatten.each do |piece|
      if piece
        if piece.class == King && piece.color == our_color
          return piece.current_pos
          break
        end
      end
    end
  end
end


class ChessMoveError < StandardError
end
