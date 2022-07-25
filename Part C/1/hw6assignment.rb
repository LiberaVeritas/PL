# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # enhancement 2, add additional pieces
  All_My_Pieces = All_Pieces + [rotations([[0, 0], [0, -1], [-1, 0], [1, 0], [-1, -1]]),
                               [[[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]],
                               [[0, 0], [0, -1], [0, 1], [0, -2], [0, 2]]],
                               rotations([[0, 0], [0, -1], [1, 0]])]

  # override to use MyPiece and All_My_Pieces
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
end

class MyBoard < Board

  # override to use MyPiece
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500

    @cheat = false # cheat flag for enhancement 3
  end

  def cheat?
    @cheat
  end
  
  # with cheat case
  def next_piece
    if cheat?
      @current_block = MyPiece.new([[[0, 0]]], self)
      @cheat = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # enhanced to work with pieces made with any number of blocks
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..locations.size-1).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # enhancement 3, cheat for 100 points
  def cheat
    if !cheat? and @score >= 100
      @score -= 100
      @game.update_score
      @cheat = true
    end
  end
end

class MyTetris < Tetris

  # enhancement 1, add 'u' for 180 rotation
  # enhancement 3, add 'c' key to cheat
  def key_bindings
    @root.bind('u', proc {@board.rotate_clockwise; @board.rotate_clockwise})
    @root.bind('c', proc {@board.cheat})
    super
  end

  def rotate_180
    @board.rotate_clockwise
    @board.rotate_clockwise
  end

  # override to use MyBoard
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
end


