require 'oystercard'
describe Oystercard do

  let(:liverpool_street)  {double :station, name: "Liverpool Street"}
  let(:farringdon)        {double :station, name: "Farringdon"}


  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end

    it 'should deduct by 6 if you touch in twice' do
      subject.top_up(20)

      expect{ 2.times{subject.touch_in(liverpool_street)} }.to change{ subject.balance}.by -6
    end
  end

  describe '#top_up' do

    MAXIMUM = Oystercard::MAXIMUM

    it 'should increase the balance by 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by (10)
    end
    it 'should increase the balance by 5 twice' do
      expect{ 2.times{subject.top_up(5)} }.to change{ subject.balance }.by (10)
    end
    it "shouldn't allow user to exceed maximum balance" do
      expect{ subject.top_up(100) }.to raise_error("Warning maximum balance is #{MAXIMUM}")
    end
  end

  # describe '#deduct' do
  #   it 'should deduct the specified amount from balance' do
  #     subject.top_up(10)
  #     expect { subject.deduct(5) }.to change{ subject.balance }.by (-5)
  #   end
  # end

  describe '#touch_in' do
  
    it 'should check for a minimum of £1 journey price' do
      # station = double('Station')
      expect{ subject.touch_in(liverpool_street)}.to raise_error("Minimum £1 required to travel")
    end
    # it 'should record the station of entry' do
    #   # station = double('Station')
    #   subject.top_up(1)
    #   expect{ subject.touch_in(liverpool_street) }.to change{ subject.entry_station }
    # end
  end

  

  describe '#touch_out' do
    it 'should deduct 2 from the balance when travel from zone 1 to zone 2' do
      # station = double('Station')
      subject.top_up(10)
      subject.touch_in(liverpool_street)
      expect{ subject.touch_out(farringdon) }.to change{ subject.balance }.by (-2)
    end

    it 'should deduct 2 from the balance when travel from zone 2 to zone 1' do
      # station = double('Station')
      subject.top_up(10)
      subject.touch_in(farringdon)
      expect{ subject.touch_out(liverpool_street) }.to change{ subject.balance }.by (-2)
    end

    it 'should deduct the balance by 6' do
      subject.top_up(10)
      expect{ subject.touch_out(farringdon) }.to change{ subject.balance }.by (-6)
    end

  end



end
