class Sudoku
  def initialize(board)
    @board = board
    @size = 9
    @box_size = 3
  end

  def print_board
    @board.each do |row|
      puts row.join(" ")
    end
  end

  def solve
    empty_cell = find_empty
    return true unless empty_cell

    row, col = empty_cell

    (1..9).each do |num|
      if valid?(num, row, col)
        @board[row][col] = num

        return true if solve

        @board[row][col] = 0
      end
    end

    false
  end

  private

  def find_empty
    (0...@size).each do |row|
      (0...@size).each do |col|
        return [row, col] if @board[row][col] == 0
      end
    end
    nil
  end

  def valid?(num, row, col)
    !in_row?(num, row) && !in_col?(num, col) && !in_box?(num, row, col)
  end

  def in_row?(num, row)
    @board[row].include?(num)
  end

  def in_col?(num, col)
    @board.any? { |row| row[col] == num }
  end

  def in_box?(num, row, col)
    box_row_start = row / @box_size * @box_size
    box_col_start = col / @box_size * @box_size

    (0...@box_size).each do |i|
      (0...@box_size).each do |j|
        return true if @board[box_row_start + i][box_col_start + j] == num
      end
    end
    false
  end
end