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
      @ship.hit
    end
  end

  def render(show = true)
    if show
      if fired_upon? == false && empty? == false
        return "S"
      elsif fired_upon? == true && empty? == true
        return "M"
      elsif fired_upon? == true && @ship.sunk? == true
        return "X"
      elsif fired_upon? == true && empty? == false
        return "H"
      else fired_upon? == false
          return "."
      end
    end
  end
end
