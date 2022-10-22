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
end
