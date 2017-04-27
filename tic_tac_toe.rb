require_relative './board'
require_relative './human_player'
require_relative './tic_tac_toe_argument_error'

class TicTacToe

  def initialize(player_one=HumanPlayer.new, player_two=HumanPlayer.new)
    @board = Board.new
    @player_one = player_one
    @player_two = player_two
    @turn_player = player_one
    @player_one.piece = :X
    @player_two.piece = :O
  end

  def play
    until @board.over?
      begin
        puts @board
        pos = @turn_player.get_move
        @board.set(pos, turn_player_piece)
      rescue TicTacToeArgumentError => e
        puts "#{e.message} Please try again."
        retry
      end
      @turn_player = other_player
    end

    puts @board
    puts @board.winner ? "#{@board.winner} won!" : "Tie game!"
  end

  def other_player
    @turn_player == @player_one ?  @player_two : @player_one
  end

  def turn_player_piece
    @turn_player == @player_one ? :X : :O
  end

end

if __FILE__ == $PROGRAM_NAME
  game = TicTacToe.new
  game.play
end
