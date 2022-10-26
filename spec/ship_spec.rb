require './lib/ship'

RSpec.describe Ship do
  let(:cruiser) { Ship.new("Cruiser", 3) }
  it 'exist' do
    expect(cruiser).to be_a(Ship)
  end

  it 'has a name' do
    expect(cruiser.name).to eq("Cruiser")
  end

  it 'has a length' do
    expect(cruiser.length).to eq(3)
  end

  it 'has a default health' do
    expect(cruiser.health).to eq(cruiser.length)
  end

  it 'has a default sink value of false' do
    expect(cruiser.sunk?).to be(false)
  end

  it 'can hit a ship' do
    cruiser.hit

    expect(cruiser.health).to eq(2)
  end

  it 'can get hit mulitple times' do
    cruiser.hit
    cruiser.hit

    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)
  end

  it 'can sink the ship' do
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
