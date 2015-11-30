require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
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
end
