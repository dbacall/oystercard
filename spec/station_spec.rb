require 'station'

describe Station do

  describe '#zone' do
    it 'should display zone' do
      station = Station.new("Liverpool_street")
      expect( station.zone ).to eq(1)
    end
  end
  describe '#name' do
    it 'should display name' do
      station = Station.new("Liverpool_street")
      expect( station.name ).to eq("Liverpool_street")
    end
  end
end
