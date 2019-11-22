require 'station'

describe Station do

  
  describe '#name' do
    it 'should display name' do
      station = Station.new("Liverpool_street")
      expect( station.name ).to eq("Liverpool_street")
    end
  end
  
end
