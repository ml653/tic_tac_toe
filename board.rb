require_relative './tic_tac_toe_argument_error'

class Board

  attr_reader :matrix

  def initialize matrix=Array.new(3){ Array.new(3) }
    @matrix = matrix
  end

  # Stringify board to readable string for printing,
  # appending row and column indexes
  def to_s
    "\n   #{(0...@matrix.length).to_a.join(' ')}\n" +
    @matrix.map.with_index do |row,i|
      "#{i}  #{row.map {|cell| cell.nil? ? " " : cell}.join(' ')}"
    end.join("\n")
  end

  def get(pos)
    row, col = pos
    @matrix[row][col]
  end

  def set(pos, piece)
    raise TicTacToeArgumentError.new("Out of bounds.") unless in_bounds?(pos)
    raise TicTacToeArgumentError.new("Occupied.") unless piece.nil? || get(pos).nil?
    row, col = pos
    @matrix[row][col] = piece
  end

  def over?
    full? || !winner.nil?
  end

  def winner
    x_moves = get_pos_by(:X)
    o_moves = get_pos_by(:O)

    winning_moves.each do |winning_set|
      return :X if (winning_set - x_moves).empty?
      return :O if (winning_set - o_moves).empty?
    end
    nil
  end

  private
  def full?
    @matrix.flatten.all? {|cell| !cell.nil? }
  end

  def winning_rows
    Array.new(3).map.with_index do |_,i|
      Array.new(3).map.with_index {|_, j| [i,j]}
    end
  end

  # Retrieve array of all winning sets of positions with three in a row
  # e.g. [[[0,0],[0,1],[0,2]], [[1,0],[2,1],[3,2]],...]
  def winning_moves
    winning_diag = [[[0,0],[1,1],[2,2]],[[0,2],[1,1],[2,0]]]
    winning_diag + winning_rows +
     winning_rows.map{|row| row.map{|cell| cell.reverse}}
  end

  # Maps matrix from cell => { pos: [row, col], content: cell }
  def matrix_with_pos
    @matrix.map.with_index do |row, i|
      row.map.with_index {|cell, j| { pos: [i,j], content: cell } }
    end
  end

  # Retrieve array of positions by :X, :0, or nil (available positions)
  def get_pos_by(type)
    matrix_with_pos
    .flatten
    .select {|cell| cell[:content] == type }
    .map{|hash| hash[:pos]}
  end

  def in_bounds?(pos)
    pos.first.between?(0, 2) && pos.last.between?(0, 2)
  end

end
