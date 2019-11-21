require 'journey'

describe Journeys do

  let(:liverpool_street) {double :station}
  let(:farringdon) {double :station}

  describe '#entry_station' do
    it 'should return the entry station' do
      subject.entry_station = liverpool_street
      expect(subject.entry_station).to eq(liverpool_street)
    end
  end

  describe '#exit_station' do
    it 'should return the exit station' do
      subject.exit_station = farringdon
      expect(subject.exit_station).to eq(farringdon)
    end
  end

  describe "#journeys_log" do
    it "starts as an empty array" do
      expect(subject.journeys_log).to eq []
    end

    it "should return an empty array after fare method called" do
      subject.add_entry(liverpool_street)
      subject.add_exit(farringdon)
      subject.entry_penalty
      expect(subject.journeys_log).to eq []
    end
  end

  describe "#journey_logger" do
    it "should return an array with one journey after touch_in and touch_out once" do
      subject.add_entry(liverpool_street)
      subject.add_exit(farringdon)
      subject.journey_logger
      expect(subject.journeys_log).to eq [{"Entry station" => liverpool_street, "Exit station" => farringdon}]
    end
  end

  describe '#entry_penalty' do
    it 'should return 0 if neither entry or exit stations are nil' do
      subject.add_entry(liverpool_street)
      subject.add_exit(farringdon)
      expect(subject.entry_penalty).to eq(0)
    end
    it 'should return 6 if either entry or exit station is nil' do
      subject.add_entry(liverpool_street)
      expect(subject.entry_penalty).to eq(6)
    end
  end

  describe "#fare" do
    it 'should return 6 if entry station is nil' do
      subject.add_exit(farringdon)
      expect(subject.fare).to eq(6)
    end
  end

end
