require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a(Board)
  end

  it 'has cells' do
    board = Board.new

    expect(board.cells).to be_a(Hash)
  end

  it 'can validate a coordinate' do
    board = Board.new

    expect(board.cells).to be_a(Hash)
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
  end

  it 'can validate a ship placement based on length' do
   board = Board.new
   cruiser = Ship.new("Cruiser", 3)
   submarine = Ship.new("Submarine", 2)

   expect(board).to be_a(Board)
   expect(cruiser).to be_a(Ship)
   expect(submarine).to be_a(Ship)

   expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
   expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
 end

  it 'can test if coordinates are horizontal' do
    board = Board.new
    expect(board.horizontal_coordinates(["A1", "A2", "A3"])).to be(true)
    expect(board.horizontal_coordinates(["A1", "B2", "A3"])).to be(false)
  end

  it 'can test if coordinates are vertical' do
    board = Board.new
    expect(board.vertical_coordinates(["A1", "B1", "C1"])).to be(true)
    expect(board.vertical_coordinates(["A1", "B2", "A3"])).to be(false)
  end

  it 'can check for horiztonal consecutiveness' do
    board = Board.new
    expect(board.consecutive_spaces(["A1", "A2", "A3"])).to be(true)
    expect(board.consecutive_spaces(["A1", "B2", "A3"])).to be(false)
  end

  it 'can check for vertical consecutiveness' do
    board = Board.new
    expect(board.consecutive_spaces(["A1", "B1", "C1"])).to be(true)
    expect(board.consecutive_spaces(["A2", "B1", "C1"])).to be(false)
  end

 it 'can validate a ship placement based on consecutiveness' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board).to be_a(Board)
    expect(cruiser).to be_a(Ship)
    expect(submarine).to be_a(Ship)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
  end

  it 'can validate a ship placement based on being diagonal' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board).to be_a(Board)
    expect(cruiser).to be_a(Ship)
    expect(submarine).to be_a(Ship)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
  end

  it 'can have a valid ship placement' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board).to be_a(Board)
    expect(cruiser).to be_a(Ship)
    expect(submarine).to be_a(Ship)

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
  end

  it 'can place a ship on consecutive cells' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = Cell.new("A1")
    cell_2 = Cell.new("A2")
    cell_3 = Cell.new("A3")

    expect(board).to be_a(Board)
    expect(cruiser).to be_a(Ship)
    expect(cell_1).to be_a(Cell)
    expect(cell_2).to be_a(Cell)
    expect(cell_3).to be_a(Cell)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(cell_1 = board.cells["A1"]).to be_a(Cell)
    expect(cell_2 = board.cells["A2"]).to be_a(Cell)
    expect(cell_3 = board.cells["A3"]).to be_a(Cell)

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cell_2.ship)
  end

  it 'can check that ships do not overlap' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
  end

  it 'can test for overlapping ships' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.empty_cells(["A1", "B1"])).to eq(false)
  end

  it 'can render a board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

    board.place(cruiser, ["A1", "A2", "A3"]) 
  
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'can place a ship and miss' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = Cell.new("B1")

    board.place(cruiser, ["A1", "A2", "A3"]) 
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_1.fire_upon
    expect(cell_1.fired_upon?).to eq(true)
    expect(cell_1.empty?).to eq(true)
    expect(cell_1.render).to eq("M")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB M . . . \nC . . . . \nD . . . . \n")
  end

  it 'can place a ship and hit' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = Cell.new("A1")

    board.place(cruiser, ["A1", "A2", "A3"]) 
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_1.fire_upon
    expect(cell_1.fired_upon?).to eq(true)
    expect(cell_1.empty?).to eq(false)
    expect(cell_1.render).to eq("H")
    expect(board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'can sink a ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = Cell.new("A1")
    cell_2 = Cell.new("A2")
    cell_3 = Cell.new("A3")

    cell_1.place_ship(cruiser)
    cell_2.place_ship(cruiser)
    cell_3.place_ship(cruiser)
    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_1.fire_upon
    expect(cell_1.fired_upon?).to eq(true)
    expect(cell_1.empty?).to eq(false)
    expect(cell_1.render).to eq("H")
    expect(cruiser.sunk?).to be(false)

    # expect(board.render).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_2.fire_upon
    expect(cell_2.fired_upon?).to eq(true)
    expect(cell_2.empty?).to eq(false)
    expect(cell_2.render).to eq("H")
    expect(cruiser.sunk?).to be(false)

    expect(board.render(true)).to eq("  1 2 3 4 \nA H X T . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_3.fire_upon
    expect(cell_3.fired_upon?).to eq(true)
    expect(cell_3.empty?).to eq(false)
    expect(cell_1.render).to eq("H")
    expect(cell_2.render).to eq("H")
    expect(cell_3.render).to eq("H")
    expect(cruiser.sunk?).to be(false)

    expect(board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
  end
end