require './lib/ship'

RSpec.describe Ship do

  it 'exist' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
  end

  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
  end

  it 'has a length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it 'has a default health' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(cruiser.length)
  end

  it 'has a default sink value of false' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be(false)
  end

  it 'can hit a ship' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    expect(cruiser.health).to eq(2)
  end

  it 'can get hit mulitple times' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit

    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)
  end

  it 'can sink the ship' do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.hit
      expect(cruiser.health).to eq(2)
      expect(cruiser.sunk?).to be(false)

      cruiser.hit
      expect(cruiser.health).to eq(1)
      expect(cruiser.sunk?).to be(false)

      cruiser.hit
      expect(cruiser.health).to eq(0)
      expect(cruiser.sunk?).to be(true)
  end

end
