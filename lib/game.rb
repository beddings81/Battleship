require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class Game
attr_reader :player, :computer, :player_sunk, :computer_sunk

  def initialize
    @player = Player.new
    @computer = Player.new
    @player_sunk = 0
    @computer_sunk = 0
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    response = gets.chomp
    if response == "p"
      start_game
    elsif response == "q"
      puts "Goodbye!"
      exit
    else
      puts "Invalid input: Enter p to play. Enter q to quit."
      main_menu
    end
  end

  def start_game
    puts "I have laid out my ships on the grid."
    puts "=============COMPUTER BOARD============="
    @player.computer_board(@computer.board)
    @computer.computer_place_cruiser
    @computer.computer_place_submarine
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "==============PLAYER BOARD=============="
    puts @player.board.render
  end

  def setup_board
    @player.place_cruiser
    @player.place_submarine
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    until player.computer_sunk == 5 || player.player_sunk == 5
      @player.player_shots
      break if player.computer_sunk == 5 || player.player_sunk == 5
      @player.computer_shots
      @computer_sunk += player.computer_sunk
      @player_sunk += player.player_sunk
    end
  end

  def winner
    if player.computer_sunk == 5
      puts "YOU WIN smarty pants, you're smarter than a computer!"
    else
      puts "I WIN. Good luck next time human!"
    end
  end
end
