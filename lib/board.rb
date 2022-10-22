require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => cell = Cell.new("A1"),
      "A2" => cell = Cell.new("A2"),
      "A3" => cell = Cell.new("A3"),
      "A4" => cell = Cell.new("A4"),
      "B1" => cell = Cell.new("B1"),
      "B2" => cell = Cell.new("B2"),
      "B3" => cell = Cell.new("B3"),
      "B4" => cell = Cell.new("B4"),
      "C1" => cell = Cell.new("C1"),
      "C2" => cell = Cell.new("C2"),
      "C3" => cell = Cell.new("C3"),
      "C4" => cell = Cell.new("C4"),
      "D1" => cell = Cell.new("D1"),
      "D2" => cell = Cell.new("D2"),
      "D3" => cell = Cell.new("D3"),
      "D4" => cell = Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    coordinate_names = @cells.keys
    if @cells.keys.include?(coordinate)
      return true
    else
      return false
    end
  end

  def valid_placement?(ship, ship_coordinate)
    if consecutive_spaces(ship_coordinate) && ship_coordinate.length == ship.length && empty_cells(ship_coordinate)
      true
    else
      false
    end
  end

  def consecutive_spaces(coordinate_array)
    if horizontal_coordinates(coordinate_array) == true
      numbers = coordinate_array.map do |coordinate|
        coordinate[1].to_i
      end
      consecutive_numbers = true
      numbers.each_cons(2) do |number_pairs|
        if number_pairs[0] + 1 != number_pairs[1]
          consecutive_numbers = false
        end
      end
      consecutive_numbers
    elsif vertical_coordinates(coordinate_array) == true
      letters = coordinate_array.map do |coordinate|
        coordinate[0].ord
      end
      consecutive_letters = true
        letters.each_cons(2) do |letter_pairs|
          if letter_pairs[0].ord + 1 != letter_pairs[1]
            consecutive_letters = false
          end
        end
      consecutive_letters
    else
      false
    end
  end

  def horizontal_coordinates(coordinate_array)
    coordinate_letters = coordinate_array.map do |coordinate|
      coordinate[0]
    end
    coordinate_letters.uniq.length == 1
  end

  def vertical_coordinates(coordinate_array)
    coordinate_numbers = coordinate_array.map do |coordinate|
      coordinate[1]
    end
    coordinate_numbers.uniq.length == 1
  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def empty_cells(coordinate_array)
    if coordinate_array.all? do |coordinate|
        @cells[coordinate].empty? == true
      end
      true
    else 
      false
    end
  end

  def render(show_ships = false)
    if show_ships == false
       "  1 2 3 4 \n" +
       "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
       "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
       "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
       "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
    else
      
      # board.place(ship, coordinate_array)
      # we have access to the coordinates
      # iterate through them to place in cell?

      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
      "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
      "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
      "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
    end
  end
end


  #“M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
  # "."" if the cell has not been fired upon.
  # “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
  # “X” if the cell has been fired upon and its ship has been sunk.
  # Note that all of the cells that contain that sunken ship should render as an “X”, 
      #not just the cell that resulted in the ship being sunk.

      # try string interpolation for each cell
      # still need 1,2,3,4 
      #may have to iterate through @cells - might be easier/faster  way to print the cells below

# in game: gets.chomp A1 (fire upon A1) --> then we get a M X or H 
# and then we re-render the board for next turn


# "  1 2 3 4 \n" +
      # "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
      # "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
      # "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
      # "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"