require 'journey'

describe Journey do
  let(:station) { double :station }
  subject {described_class.new("Oval")}

  it "should return entry_station when entry_station method called" do 
    expect(subject.entry_station).to eq "Oval"
  end

  it "should return nil when exit_station called at first" do
    expect(subject.exit_station).to eq nil
  end

  it "should return exit_station when exit_station called once journey complete" do
    subject.exit_station = "Highgate"
    expect(subject.exit_station).to eq "Highgate"
  end

  it "should have current? value 'true' if entry_station AND NO exit_station" do
    expect(subject).to be_current
  end

  it "should have current? value 'false' if entry_station AND exit_station exist" do
    subject.exit_station = "Highgate"
    expect(subject).not_to be_current
  end

  it "should charge PENALTY_FARE if never tapped out" do 
    subject.exit_station = "Penalty fare"
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "should charge MINIMUM_AMOUNT if tapped out" do 
    subject.exit_station = "Highgate"
    expect(subject.fare).to eq Journey::MINIMUM_AMOUNT
  end

  it "should charge PENALTY_FARE if never tapped in" do 
    journey = Journey.new("Penalty fare")
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

end