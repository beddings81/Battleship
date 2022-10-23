require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Player
  attr_reader :cruiser, :submarine, :board

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
  end

  def place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_coordinate = gets.chomp.upcase.split
    while @board.valid_placement?(cruiser, cruiser_coordinate) == false
      puts "Those are invalid coordinates. Please try again!"
      cruiser_coordinate = gets.chomp.upcase.split
    end
    @board.place(cruiser, cruiser_coordinate)
    puts @board.render(true)
  end

  def place_submarine
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_coordinate = gets.chomp.upcase.split
    while @board.valid_placement?(submarine, submarine_coordinate) == false
      puts "Those are invalid coordinates. Please try again!"
      submarine_coordinate = gets.chomp.upcase.split
    end
    @board.place(submarine, submarine_coordinate)
    puts @board.render(true)
  end
end
