require './lib/ship'
require './lib/cell'

RSpec.describe Cell do

  it 'exist' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
  end

  it 'has a coordinate' do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end

  it 'has a ship' do
    cell = Cell.new("B4")

    expect(cell.ship).to be(nil)
  end

  it 'is empty by default' do
    cell = Cell.new("B4")

    expect(cell.empty?).to eq(true)
  end

  it 'can place ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
  end

  it 'can place ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

end
