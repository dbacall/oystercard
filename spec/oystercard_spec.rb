require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should increase the balance by 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by (10)
    end
    it 'should increase the balance by 5 twice' do
      expect{ 2.times{subject.top_up(5)} }.to change{ subject.balance }.by (10)
    end
    it "shouldn't allow user to exceed maximum balance" do
      expect{ subject.top_up(100) }.to raise_error("Warning maximum balance is #{subject.maximum}")
    end
  end

  # describe '#deduct' do
  #   it 'should deduct the specified amount from balance' do
  #     subject.top_up(10)
  #     expect { subject.deduct(5) }.to change{ subject.balance }.by (-5)
  #   end
  # end

  describe '#touch_in' do
    it 'should change the in_journey variable to true' do
      station = double('Station')
      subject.top_up(1)
      expect( subject.touch_in(station) ).to be_truthy
    end
    it 'should check for a minimum of £1 journey price' do
      station = double('Station')
      expect{ subject.touch_in(station)}.to raise_error("Minimum £1 required to travel")
    end
    it 'should record the station of entry' do
      station = double('Station')
      subject.top_up(1)
      expect{ subject.touch_in(station) }.to change{ subject.entry_station }
    end
  end

  describe '#touch_out' do
    it 'should change the in_journey variable to false' do
      station = double('Station')
      subject.top_up(1)
      subject.touch_in(station)
      expect( subject.touch_out ).to be_falsey
    end
    it 'should deduct the balance by an amount' do
      station = double('Station')
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.balance }.by (-1)
    end
    it 'should forget entry station' do
      station = double('Station')
      subject.top_up(1)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.entry_station }.from(station).to(nil)
    end
  end

  describe '#in_journey' do
    it 'should not be in journey by default' do
      expect( subject.in_journey ).to be_falsey
    end
  end
end
