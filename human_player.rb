require_relative './tic_tac_toe_argument_error'

class HumanPlayer

  attr_accessor :piece

  # Retrieve tuple from user e.g. [0,1]
  def get_move
    begin
      puts "#{@piece} Player: Enter a valid coordinate (row, col) e.g. \"1,2\""
      move_string = gets.chomp

      if !(move_string =~ /^\d\s*,\s*\d$/)
        raise TicTacToeArgumentError.new("Invalid format.")
      end
      move_string.split(',').map(&:to_i)

    rescue TicTacToeArgumentError => e
      puts "#{e.message}  Please try again."
      retry
    end
  end
end
