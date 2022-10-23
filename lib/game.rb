require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
attr_reader :cruiser, :submarine, :board
  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
    # @play = "p"
    # @quit = "q"
  end

  def main_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    response = gets.chomp
    if response == "p"
      p "hi"
    elsif response == "q"
      p "bye"
    else
      p "Invalid input"
    end
  end
end
