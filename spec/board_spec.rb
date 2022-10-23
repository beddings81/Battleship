require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  let(:board) { Board.new }
  it 'exists' do

    expect(board).to be_a(Board)
  end

  it 'has cells' do

    expect(board.cells).to be_a(Hash)
  end

  it 'can validate a coordinate' do

    expect(board.cells).to be_a(Hash)
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
  end

  it 'can validate a ship placement based on length' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board).to be_a(Board)
    expect(cruiser).to be_a(Ship)
    expect(submarine).to be_a(Ship)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
  end

  it 'can test if coordinates are horizontal' do
    expect(board.horizontal_coordinates(["A1", "A2", "A3"])).to be(true)
    expect(board.horizontal_coordinates(["A1", "B2", "A3"])).to be(false)
  end

  it 'can test if coordinates are vertical' do
    expect(board.vertical_coordinates(["A1", "B1", "C1"])).to be(true)
    expect(board.vertical_coordinates(["A1", "B2", "A3"])).to be(false)
  end

  it 'can check for horiztonal consecutiveness' do
    expect(board.consecutive_spaces(["A1", "A2", "A3"])).to be(true)
    expect(board.consecutive_spaces(["A1", "B2", "A3"])).to be(false)
  end

  it 'can check for vertical consecutiveness' do
    expect(board.consecutive_spaces(["A1", "B1", "C1"])).to be(true)
    expect(board.consecutive_spaces(["A2", "B1", "C1"])).to be(false)
  end

  it 'can validate a ship placement based on consecutiveness' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
  end

  it 'can validate a ship placement based on being diagonal' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
  end

  it 'can have a valid ship placement' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
  end

  it 'can place a ship on consecutive cells' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser_2 = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.cells["A1"].ship).to eq(cruiser)
    expect(board.cells["A2"].ship).to eq(cruiser)
    expect(board.cells["A3"].ship).to eq(cruiser)
    expect(board.cells["A3"].ship).to_not eq(cruiser_2)
    expect(board.cells["A3"].ship).to eq(board.cells["A2"].ship)
  end

  it 'can check that ships do not overlap' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
  end

  it 'can test for overlapping ships' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.empty_cells(["A1", "B1"])).to eq(false)
  end

  it 'can render a board' do
    cruiser = Ship.new("Cruiser", 3)

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    expect(cell_1.empty?).to eq(false)
    expect(cell_2.empty?).to eq(false)
    expect(cell_3.empty?).to eq(false)

    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'can place a ship and miss' do
    cruiser = Ship.new("Cruiser", 3)
  
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["B1"]
  
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    cell_4.fire_upon
    expect(cell_4.fired_upon?).to eq(true)
    expect(cell_4.empty?).to eq(true)
    expect(cell_4.render).to eq("M")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB M . . . \nC . . . . \nD . . . . \n")
  end

  it 'can place a ship and hit' do
    cruiser = Ship.new("Cruiser", 3)
  
    board.place(cruiser, ["C1", "C2", "C3"])
    cell_1 = board.cells["C1"]
    cell_2 = board.cells["C2"]
    cell_3 = board.cells["C3"]
    #this is the player who places the cruiser
    expect(board.render(true)).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC S S S . \nD . . . . \n")

    cell_1.fire_upon
    expect(cell_1.fired_upon?).to eq(true)
    expect(cell_1.empty?).to eq(false)
    expect(cell_1.render).to eq("H")
    # this is what the computer sees
    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC H . . . \nD . . . . \n")
  end

  it 'can sink a ship' do
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["D2", "D3", "D4"])
    cell_1 = board.cells["D2"]
    cell_2 = board.cells["D3"]
    cell_3 = board.cells["D4"]

    cell_1.fire_upon
    expect(cell_1.fired_upon?).to eq(true)
    expect(cell_1.empty?).to eq(false)
    expect(cell_1.render).to eq("H")
    expect(cruiser.sunk?).to be(false)
    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . H . . \n")

    cell_2.fire_upon
    expect(cell_2.fired_upon?).to eq(true)
    expect(cell_2.empty?).to eq(false)
    expect(cell_2.render).to eq("H")
    expect(cruiser.sunk?).to be(false)
    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . H H . \n")

    cell_3.fire_upon
    expect(cell_3.fired_upon?).to eq(true)
    expect(cell_3.empty?).to eq(false)
    expect(cell_1.render).to eq("X")
    expect(cell_2.render).to eq("X")
    expect(cell_3.render).to eq("X")
    expect(cruiser.sunk?).to be(true)
    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . X X X \n")
  end
end