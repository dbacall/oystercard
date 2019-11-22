require 'journey'

describe Journey do

  let(:liverpool_street) {double :station, name: "Liverpool Street"}
  let(:farringdon) {double :station, name: "Farringdon"}
  



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
