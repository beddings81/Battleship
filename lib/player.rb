require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Player
  attr_reader :cruiser, :submarine, :board_cpu, :board

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

  def computer_board(computer_board)
    @board_cpu = computer_board
  end

  def computer_place_cruiser
    coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4" ]
    cruiser_coordinate = [] 
      while @board.valid_placement?(cruiser, cruiser_coordinate) == false
        cruiser_coordinate = coordinates_array.sample(3)
      end
    @board.place(cruiser, cruiser_coordinate)
    puts @board.render(true)
  end

  def computer_place_submarine
    coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4" ]
    submarine_coordinate = coordinates_array.sample(2)
      while @board.valid_placement?(submarine, submarine_coordinate) == false
        submarine_coordinate = coordinates_array.sample(2)
      end
    @board.place(submarine, submarine_coordinate)
    puts @board.render(true)
  end

  def player_shots
    puts "Enter the coordinate for your shot:"
    player_shot = gets.chomp.upcase
    while @board.valid_coordinate?(player_shot) == false
      puts "This is not a valid coordinate, please enter a valid coordinate:"
      player_shot = gets.chomp.upcase
    end
    if @board.valid_coordinate?(player_shot) == true
      @board_cpu.cells[player_shot].fire_upon
      puts @board_cpu.render
      if @board_cpu.cells[player_shot].fired_upon? == true && @board_cpu.cells[player_shot].empty? == false && @board_cpu.cells[player_shot].ship.sunk? == true
        puts "Your shot on #{player_shot} sunk my battleship!"
      elsif @board_cpu.cells[player_shot].fired_upon? == true && @board_cpu.cells[player_shot].empty? == false
        puts "Your shot on #{player_shot} was a hit!"
      else
        puts "Your shot on #{player_shot} was miss."
      end
    end
  end
end