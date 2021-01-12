require 'oyster_card'

describe OysterCard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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
    subject {described_class.new(10)}
    it 'in_journey? should be false to begin with' do
      expect(subject).not_to be_in_journey
    end

    it 'in_journey? should be true after touch_in' do
      #card = OysterCard.new(10)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'in_journey? should be false after touch_out' do
      #card = OysterCard.new(12)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'error should be raised when trying to touch_in with less than MINIMUM_AMOUNT' do
      card = OysterCard.new
      erro = "Need to have at least £#{OysterCard::MINIMUM_AMOUNT}."
      expect { card.touch_in(entry_station) }.to raise_error erro
    end

    it 'balance should be deducted by MINIMUM_AMOUNT after touch_out' do
      #card = OysterCard.new(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-OysterCard::MINIMUM_AMOUNT)
    end
  end

  context 'entry_station' do
    subject {described_class.new(10)}
    it 'should return previous station' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    it 'should return previous station' do
      subject.touch_in(entry_station)
      expect(subject.touch_out(exit_station)).to eq nil
    end
    it 'should have an empty history by default' do
      expect(subject.list_of_journeys).to be_empty
    end
    it "adds a journey when journey complete" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      arra = [{:entry_station => entry_station, :exit_station => exit_station}]
      expect(subject.list_of_journeys).to eq arra
    end
  end
end
