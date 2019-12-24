require "journeylog"

describe Journeylog do

  let(:liverpool_street)  {double :station, name: "Liverpool Street"}
  let(:farringdon)        {double :station, name: "Farringdon"}
  let(:kilburn)           {double :station, name: "Kilburn"}
  let(:edgware)           {double :station, name: "Edgware"}
  let(:journey)           {double :journey}

  describe "#journey_log" do
    it "starts as an empty array" do
      expect(subject.journey_log).to eq []
    end

    it "should return an empty array after fare method called" do
      subject.start(liverpool_street)
      subject.finish(farringdon)
      expect(subject.journey_log).to eq []
    end
  end

  describe "#journey_logger" do
    it "should return an array with one journey after touch_in and touch_out once" do
      subject.start(liverpool_street)
      subject.finish(farringdon)
      subject.journey_logger
      expect(subject.journey_log).to eq [{"Entry station" => liverpool_street.name, "Exit station" => farringdon.name}]
    end

    it "should return an array with two journeys" do
    subject.start(liverpool_street)
    subject.finish(farringdon)
    subject.journey_logger
    subject.start(kilburn)
    subject.finish(edgware) 
    subject.journey_logger
    expect(subject.journey_log).to eq [{"Entry station" => liverpool_street.name, "Exit station" => farringdon.name},
     {"Entry station" => kilburn.name, "Exit station" => edgware.name}]
    end
  end
end


