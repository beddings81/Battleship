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
end



#  cruiser.name
# #=> "Cruiser"
#
#  cruiser.length
# #=> 3
#
#  cruiser.health
# #=> 3
#
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
