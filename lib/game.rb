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
    puts @computer.board_cpu.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    @player.shots
  end

# Player choosing a coordinate to fire on
# Computer choosing a coordinate to fire on
# Reporting the result of the Player’s shot
# Reporting the result of the Computer’s shot
end