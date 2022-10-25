require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
attr_reader :player, :computer

  def initialize
    @player = Player.new
    @computer = Player.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    response = gets.chomp
    if response == "p"
      start_game
    elsif response == "q"
      puts "bye"
    else
      puts "Invalid input"
    end
  end

  def start_game
    puts "I have laid out my ships on the grid."
    @player.computer_board(@computer.board)
    @computer.computer_place_cruiser
    @computer.computer_place_submarine
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player.board.render
  end

  def setup_board
    @player.place_cruiser
    @player.place_submarine
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    while @player.cruiser.sunk? == false && @player.submarine.sunk? == false
      @player.player_shots
      @player.computer_shots(@computer.board)
    end
  end

  def player_wins
    # player turn
    # if .sunk? == true
    #   put "You are awinner"
    # else continue with turn
  end

  def computer_wins
    # computer return
  end
end

# @player.cruiser.sunk? <<< ended the game after player sunk computer aka computer lost
# @computer.cruiser.sunk?
