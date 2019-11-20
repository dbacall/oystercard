require 'journey'

describe Journey do

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
  end

  describe "#journey_logger" do
    it "should return an array with one journey after touch_in and touch_out once" do
      subject.add_entry(liverpool_street)
      subject.add_exit(farringdon)
      subject.journey_logger
      expect(subject.journeys_log).to eq [{"Entry station": liverpool_street, "Exit station": farringdon}]
    end

  end

end
