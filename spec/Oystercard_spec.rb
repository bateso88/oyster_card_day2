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

  #it 'deducts a specified amount from the balance' do
  #  card = Oystercard.new(10)
  #  expect(card.deduct(5)).to eq 5
  #end

  it 'expect in_journey? to be false' do
    expect(subject).not_to be_in_journey
  end

  it 'expects in_journey to be true after touch_in' do
    card = Oystercard.new(10)
    card.touch_in
    expect(card.in_journey?).to eq true
  end

  it "expects in_journey to be false after touch_out" do
    card = Oystercard.new(12)
    card.touch_in
    card.touch_out
    expect(card.in_journey?).to eq false
  end

  it "expects error to be raised when trying to touch_in with less than £1" do
    card = Oystercard.new
    expect { card.touch_in }.to raise_error "Need to have at least £#{Oystercard::MINIMUM_AMOUNT}"
  end

  it 'expects balance to be deducted after touch_out' do
    card = Oystercard.new(10)
    card.touch_in
    expect {card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_AMOUNT)
  end
end
