require 'oyster_card'

describe OysterCard do

  let(:station1) { $station1 = "Highgate" }
  let(:station2) { $station2 = "Archway" }

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
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it 'should raise error if balance exceeds 90' do
      expect { subject.top_up(91) }.to raise_error "Cannot exceed £#{OysterCard::BALANCE_LIMIT} limit."
    end
  end

  context 'in_journey? ; touch_in ; touch_out' do
    it 'in_journey? should be false to begin with' do
      expect(subject).not_to be_in_journey
    end

    it 'in_journey? should be true after touch_in' do
      card = OysterCard.new(10)
      card.touch_in(station1)
      expect(card).to be_in_journey
    end

    it 'in_journey? should be false after touch_out' do
      card = OysterCard.new(12)
      card.touch_in(station1)
      card.touch_out(station2)
      expect(card).not_to be_in_journey
    end

    it 'error should be raised when trying to touch_in with less than MINIMUM_AMOUNT' do
      erro = "Need to have at least £#{OysterCard::MINIMUM_AMOUNT}."
      expect { subject.touch_in(station1) }.to raise_error erro
    end

    it 'balance should be deducted by MINIMUM_AMOUNT after touch_out' do
      card = OysterCard.new(10)
      card.touch_in(station1)
      expect { card.touch_out(station2) }.to change{ card.balance }.by(-OysterCard::MINIMUM_AMOUNT)
    end
  end

  context 'entry_station' do
    it 'should return previous station' do
      card = OysterCard.new(10)
      card.touch_in(station1)
      expect(card.entry_station).to eq "Highgate"
    end
    it 'should return previous station' do
      card = OysterCard.new(10)
      card.touch_in(station1)
      expect(card.touch_out(station2)).to eq nil
    end
    it 'should have an empty history by default' do
      card =  OysterCard.new(10)
      expect(card.list_of_journeys).to be_empty
    end
    it "adds a journey when journey complete" do
      card = OysterCard.new(10)
      card.touch_in(station1)
      card.touch_out(station2)
      arra = [{:entry_station => station1, :exit_station => station2}]
      expect(card.list_of_journeys).to eq arra
    end
  end
end
