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

end


#  cruiser.sunk?
# #=> false
#
#  cruiser.hit
#
#  cruiser.health
# #=> 2
#
#  cruiser.hit
#
#  cruiser.health
# #=> 1
#
#  cruiser.sunk?
# #=> false
#
#  cruiser.hit
#
#  cruiser.sunk?
# #=> true
