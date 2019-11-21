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


  describe '#entry_penalty' do
    it 'should return 0 if entry station is nil' do
      expect(subject.entry_penalty).to eq(0)
    end
    it 'should return 6 if either exit station is nil' do
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
