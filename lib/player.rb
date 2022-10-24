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
    @board_cpu = Board.new
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

  def computer_place_cruiser
    coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4" ]
    cruiser_coordinate = [] 
      while @board_cpu.valid_placement?(cruiser, cruiser_coordinate) == false
        cruiser_coordinate = coordinates_array.sample(3)
      end
    @board_cpu.place(cruiser, cruiser_coordinate)
    puts @board_cpu.render
  end

  def computer_place_submarine
    coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4" ]
    submarine_coordinate = coordinates_array.sample(2)
      while @board_cpu.valid_placement?(submarine, submarine_coordinate) == false
        submarine_coordinate = coordinates_array.sample(2)
      end
    @board_cpu.place(submarine, submarine_coordinate)
    puts @board_cpu.render
  end
end
