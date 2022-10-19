require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  it 'exist' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
  end

  it 'has a coordinate' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
    expect(cell.coordinate).to eq("B4")
  end

  it 'has a ship' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
    expect(cell.ship).to be(nil)
  end

  it 'is empty by default' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
    expect(cell.empty?).to eq(true)
  end

  it 'can place ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
  end

  it 'can place ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it 'can be fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
    expect(cell.fired_upon?).to eq(false)
  end

  it 'can lose health when fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
    expect(cell.fired_upon?).to eq(false)
    expect(cell.ship.health).to eq(3)

    cell.fire_upon

    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end

  it 'can render as "." if it has not been fired upon' do
    cell_1 = Cell.new("B4")

    expect(cell_1).to be_a(Cell)
    expect(cell_1.render).to eq(".")
  end

  it 'can render as "M" if it is fired upon but missed' do
    cell_1 = Cell.new("B4")

    expect(cell_1).to be_a(Cell)
    expect(cell_1.render).to eq(".")

    cell_1.fire_upon

    expect(cell_1.render).to eq("M")
  end

  it 'can render "S" if it contains a ship' do
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell_1).to be_a(Cell)
    expect(cell_2).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell_2.place_ship(cruiser)

    expect(cell_2.render(true)).to eq("S")
  end

  it 'can render as "H" if fired upon and hit' do
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell_1).to be_a(Cell)
    expect(cell_2).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    expect(cell_2.render).to eq("H")
  end

  it 'can render as "X" if it sunk a ship' do
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    expect(cell_1).to be_a(Cell)
    expect(cell_2).to be_a(Cell)
    expect(cruiser).to be_a(Ship)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    expect(cruiser.health).to eq(2)
    expect(cruiser.sunk?).to be(false)

    cruiser.hit

    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)

    cruiser.hit

    expect(cruiser.health).to eq(0)
    expect(cruiser.sunk?).to be(true)
    expect(cell_2.render).to eq("X")
  end
end
