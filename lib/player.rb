require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Player
  attr_reader :cruiser, :submarine, :board_cpu, :board, :player_sunk, :computer_sunk

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new
    @computer_sunk = 0
    @player_sunk = 0
    @coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
  end

  def place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_coordinate = gets.chomp.upcase.split
    while @board.valid_placement?(cruiser, cruiser_coordinate) == false
      puts "Those are invalid coordinates. Please try again:"
      cruiser_coordinate = gets.chomp.upcase.split
    end
    @board.place(cruiser, cruiser_coordinate)
    puts @board.render(true)
  end

  def place_submarine
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_coordinate = gets.chomp.upcase.split
    while @board.valid_placement?(submarine, submarine_coordinate) == false
      puts "Those are invalid coordinates. Please try again:"
      submarine_coordinate = gets.chomp.upcase.split
    end
    @board.place(submarine, submarine_coordinate)
    puts @board.render(true)
  end

  def computer_board(computer_board)
    @board_cpu = computer_board
  end

  def computer_place_cruiser
   coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
   cruiser_coordinate = []
     while @board.valid_placement?(cruiser, cruiser_coordinate) == false
       cruiser_coordinate = coordinates_array.sample(3)
     end
   @board.place(cruiser, cruiser_coordinate)
   puts @board.render(true)
 end

  def computer_place_submarine
    coordinates_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    submarine_coordinate = []
      while @board.valid_placement?(submarine, submarine_coordinate) == false
        submarine_coordinate = coordinates_array.sample(2)
      end
    @board.place(submarine, submarine_coordinate)
    puts @board.render(true)
  end

  def player_shots
      puts "Enter the coordinate for your shot:"
      @player_shot = gets.chomp.upcase
      validate_the_coordinate
      @board_cpu.cells[@player_shot].fire_upon
      puts "=============COMPUTER BOARD============="
      puts @board_cpu.render
      if @board_cpu.cells[@player_shot].fired_upon? == true && @board_cpu.cells[@player_shot].empty? == false && @board_cpu.cells[@player_shot].ship.sunk? == true
        puts "Your shot on #{@player_shot} sunk my battleship!"
        @computer_sunk += 1
      elsif @board_cpu.cells[@player_shot].fired_upon? == true && @board_cpu.cells[@player_shot].empty? == false
        puts "Your shot on #{@player_shot} was a hit!"
        @computer_sunk += 1
      else
        puts "Your shot on #{@player_shot} was miss."
      end
    end

    def validate_the_coordinate
      while @board_cpu.valid_coordinate?(@player_shot) == false
        puts "This is not a valid coordinate, please enter a valid coordinate:"
        @player_shot = gets.chomp.upcase
      end
      validate_fired_upon unless @board_cpu.cells[@player_shot].nil?
    end

    def validate_fired_upon
      while @board_cpu.cells[@player_shot].fired_upon? == true
        puts "You have already fired upon this coordinate, please choose another coordinate:"
        @player_shot = gets.chomp.upcase
        validate_the_coordinate
      end
    end

  def computer_shots
    computer_coordinate = ""
    until @board.valid_coordinate?(computer_coordinate) && @board.cells[computer_coordinate].fired_upon? == false
      computer_coordinate = @coordinates_array.delete(@coordinates_array.sample)
    end
    @board.cells[computer_coordinate].fire_upon
    puts "==============PLAYER BOARD=============="
    puts @board.render
    if @board.cells[computer_coordinate].fired_upon? == true && @board.cells[computer_coordinate].empty? == false && @board.cells[computer_coordinate].ship.sunk? == true
      puts "My shot on #{computer_coordinate} sunk your battleship!"
      @player_sunk += 1
    elsif @board.cells[computer_coordinate].fired_upon? == true && @board.cells[computer_coordinate].empty? == false
      puts "My shot on #{computer_coordinate} was a hit!"
      @player_sunk += 1
    else
      puts "My shot on #{computer_coordinate} was miss."
    end
  end
end
