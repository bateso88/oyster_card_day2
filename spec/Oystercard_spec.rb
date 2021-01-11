require 'Oystercard'
describe Oystercard do
  it 'responds to balance method' do
    expect(Oystercard.new(0)).to respond_to :balance
  end

  it 'setting balance of card to 0' do
    expect(Oystercard.new(0).balance).to eq 0
  end
end
