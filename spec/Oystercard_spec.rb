require 'Oystercard'
describe Oystercard do
  it 'responds to balance method' do
    expect(Oystercard.new(0)).to respond_to :balance
  end

  it 'setting balance of card to 0' do
    expect(Oystercard.new(0).balance).to eq 0
  end

  it 'tests the default value of a card is zero' do
    expect(Oystercard.new.balance).to eq 0
  end

  it 'responds to top_up' do
    expect(subject).to respond_to :top_up
  end

  it 'top_up increases balance by value' do
    card = Oystercard.new
    card.top_up(10)
    expect(card.balance).to eq 10
  end

  describe 'top_up method' do
    it 'raise error if balance exceeds 90' do
      card = Oystercard.new
      expect { card.top_up(91) }.to raise_error "Limit of #{Oystercard::LIMIT_CONSTANT} reached"
    end
  end

  it 'deducts a specified amount from the balance' do 
    card = Oystercard.new(10)
    expect(card.deduct(5)).to eq 5
  end

end
