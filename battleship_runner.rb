require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'

loop do
  new_game = Game.new
  new_game.main_menu
  new_game.setup_board
  new_game.turn
  new_game.winner
end
