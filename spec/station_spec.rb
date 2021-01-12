require 'station'
describe Station do
  it 'should return initialised name' do
    station = Station.new("name",1)
    expect(station.name).to eq "name"
  end
  it 'should return initialised zone' do
    station = Station.new("name",1)
    expect(station.zone).to eq 1
  end
end