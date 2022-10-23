require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
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
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(show_ships)} #{@cells["A2"].render(show_ships)} #{@cells["A3"].render(show_ships)} #{@cells["A4"].render(show_ships)} \n" +
    "B #{@cells["B1"].render(show_ships)} #{@cells["B2"].render(show_ships)} #{@cells["B3"].render(show_ships)} #{@cells["B4"].render(show_ships)} \n" +
    "C #{@cells["C1"].render(show_ships)} #{@cells["C2"].render(show_ships)} #{@cells["C3"].render(show_ships)} #{@cells["C4"].render(show_ships)} \n" +
    "D #{@cells["D1"].render(show_ships)} #{@cells["D2"].render(show_ships)} #{@cells["D3"].render(show_ships)} #{@cells["D4"].render(show_ships)} \n"
  end
end

# in game: gets.chomp A1 (fire upon A1) --> then we get a M X or H 
# and then we re-render the board for next turn