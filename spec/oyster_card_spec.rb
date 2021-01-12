require 'oyster_card'

describe OysterCard do
  context 'balance' do
    it 'should respond to :balance' do
      expect(OysterCard.new(0)).to respond_to :balance
    end

    it 'should be able to initialise custom balance' do
      expect(OysterCard.new(16).balance).to eq 16
    end

    it 'should have a default balance of 0' do
      expect(OysterCard.new.balance).to eq 0
    end
  end

  context 'top_up' do 
    it 'should respond to top_up' do
      expect(subject).to respond_to :top_up
    end

    it 'should top_up balance by set value' do
      card = OysterCard.new
      card.top_up(10)
      expect(card.balance).to eq 10
    end

    it 'should raise error if balance exceeds 90' do
      card = OysterCard.new
      expect { card.top_up(91) }.to raise_error "Cannot exceed £#{OysterCard::BALANCE_LIMIT} limit."
    end
  end

  context 'in_journey? ; touch_in ; touch_out' do
    it 'in_journey? should be false to begin with' do
      expect(subject).not_to be_in_journey
    end

    it 'in_journey? should be true after touch_in' do
      card = OysterCard.new(10)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'in_journey? should be false after touch_out' do
      card = OysterCard.new(12)
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'error should be raised when trying to touch_in with less than MINIMUM_AMOUNT' do
      card = OysterCard.new
      expect { card.touch_in }.to raise_error "Need to have at least £#{OysterCard::MINIMUM_AMOUNT}."
    end

    it 'balance should be deducted by MINIMUM_AMOUNT after touch_out' do
      card = OysterCard.new(10)
      card.touch_in
      expect { card.touch_out }.to change{ card.balance }.by(-OysterCard::MINIMUM_AMOUNT)
    end
  end
end
