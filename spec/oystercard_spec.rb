require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  context '#balance' do
    it 'had a default balance of zero' do
      expect(oystercard.balance).to eq(described_class::DEFAULT_BALANCE)
    end
  end

  context 'Topped up to max balance' do
    before do
      oystercard.top_up(described_class::MAXIMUM_BALANCE)
    end

    context '#top_up' do
      it 'raises and error if topping up would exceed maximum balance' do
        max_balance = described_class::MAXIMUM_BALANCE
        expect { oystercard.top_up(max_balance + 1) }
          .to raise_error "Maximum balance of #{max_balance} exceeded"
      end
    end

    context '#touch_out' do
      it 'changes card to be not in use' do
        oystercard.touch_in
        expect { oystercard.touch_out }.to change { oystercard.in_journey }
          .to false
      end
    end
  end

  context '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      oystercard.deduct(10)
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by 1
    end
  end

  context '#deduct' do
    it 'deducts a fare from card' do
      oystercard.top_up(10)
      expect { oystercard.deduct 3 }.to change { oystercard.balance }.by(-3)
    end
  end

  context '#in_journey' do
    it 'has a boolean state in_journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  context '#touch_in' do
    it 'changes card to be in use' do
      expect { oystercard.touch_in }.to change { oystercard.in_journey }.to true
    end
  end
end
