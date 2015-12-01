require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:start) { double(:entry_station) }
  let(:finish) { double(:exit_station) }

  context '#balance' do
    it 'had a default balance of zero' do
      expect(oystercard.balance).to eq(described_class::DEFAULT_BALANCE)
    end
  end

  context '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by 1
    end
  end

  context '#in_journey' do
    it 'has a boolean state in_journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  context '#touch_in' do
    it 'fails if balance is insufficient' do
      expect { oystercard.touch_in(start) }
        .to raise_error 'Insufficient balance'
    end
  end

  context 'TOPPED UP TO MAX BALANCE' do
    let(:fare) { described_class::MINIMUM_CHARGE }
    before do
      oystercard.top_up(described_class::MAXIMUM_BALANCE)
    end

    context '#top_up' do
      it 'raises and error if topping up would exceed maximum balance' do
        max_balance = described_class::MAXIMUM_BALANCE
        expect { oystercard.top_up(1) }
          .to raise_error "Maximum balance of #{max_balance} exceeded"
      end
    end

    context '#touch_in' do
      it 'changes card to be in use' do
        expect { oystercard.touch_in(start) }
          .to change { oystercard.in_journey? }.to true
      end

      it 'remembers entry station on touch in' do
        oystercard.touch_in(start)
        expect(oystercard.entry_station).to eq(start)
      end
    end

    context '#touch_out' do
      it 'changes card to be not in use' do
        oystercard.touch_in(start)
        expect { oystercard.touch_out(fare, finish) }
          .to change { oystercard.in_journey? }.to false
      end

      it 'deducts fare from balance' do
        expect { oystercard.touch_out(fare, finish) }
          .to change { oystercard.balance }.by(-fare)
      end
    end

    context 'journey history' do

      it 'starts with empty journey history' do
        expect(oystercard.journey_history).to eq []
      end

      it 'stores journey in journey history' do
        oystercard.touch_in(start)
        oystercard.touch_out(fare, finish)
        expect(oystercard.journey_history).to include(oystercard.journey)
      end
    end
  end
end
