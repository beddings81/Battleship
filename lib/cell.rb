require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
    @ship = nil
  end

  def empty?
    if @ship == nil
      return true
    else
      return false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
      ship.hit
    end
  end
end
