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

  def valid_placement?(ship, ship_coordinates)
    # if ship_length(ship, ship_coordinates)
    #   # return false
    # else consecutive_spaces(ship_coordinates)
    #   # return true
    #
    # end
      if consecutive_spaces(ship_coordinates)
        return false
      elsif ship.length == ship_coordinates.length
        return true
      end
  end

  def consecutive_spaces(ship_coordinates)
    letters = []
    numbers = []
    ship_coordinates.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1]
      if letters.uniq.length == 1
        #wont capture A1 B1
        (numbers[-1].to_i - numbers[0].to_i) - 1 == numbers.length
        # this will always be false
      end
      letters
      numbers
    end
  end

  # def ship_length(ship, ship_coordinates)
  #   ship.length != ship_coordinates.length
  # end
end

# def horizontal_letters?(coordinate_array)
#   array_of_coordinates.map do |coordinate_letter|
#     puts coordinate_letter[0]
#   end
#   # all the letter values of coordinates
#   # think what is unique (the letter)
# end

# def vertical_numbers?(coordinate_array)
#     array_of_coordinates.map do |coordinate_number|
#       puts coordinate_number[1]
#     end
#     #all the number values of coordinates
#     # think what is unique (the numbers)
# end
