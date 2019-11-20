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
      # station = double('Station')
      subject.top_up(1)
      expect( subject.touch_in(liverpool_street) ).to be_truthy
    end
    it 'should check for a minimum of £1 journey price' do
      # station = double('Station')
      expect{ subject.touch_in(liverpool_street)}.to raise_error("Minimum £1 required to travel")
    end
    it 'should record the station of entry' do
      # station = double('Station')
      subject.top_up(1)
      expect{ subject.touch_in(liverpool_street) }.to change{ subject.entry_station }
    end
  end

  let(:liverpool_street) {double :station}
  let(:farringdon) {double :station}


  describe '#touch_out' do
    it 'should change the in_journey variable to false' do
      # station = double('Station')
      subject.top_up(1)
      subject.touch_in(liverpool_street)
      expect( subject.touch_out(farringdon) ).to be_falsey
    end
    it 'should deduct the balance by an amount' do
      # station = double('Station')
      subject.top_up(10)
      subject.touch_in(liverpool_street)
      expect{ subject.touch_out(farringdon) }.to change{ subject.balance }.by (-1)
    end
    it 'should forget entry station' do
      # station = double('Station')
      subject.top_up(1)
      subject.touch_in(liverpool_street)
      expect{ subject.touch_out(farringdon) }.to change{ subject.entry_station }.from(liverpool_street).to(nil)
    end
  end

  describe "#journeys_log" do
    it "starts as an empty array" do
      expect(subject.journeys_log).to eq []
    end

    it "should return an array with one journey after touch_in and touch_out once" do
      subject.top_up(10)
      subject.touch_in(liverpool_street)
      subject.touch_out(farringdon)
      expect(subject.journeys_log).to eq [{"Entry station": liverpool_street, "Exit station": farringdon}]
    end

  end

end
