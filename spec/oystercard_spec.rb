require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  context '#balance' do
    it 'had a default balance of zero' do
      expect(oystercard.balance).to eq(described_class::DEFAULT_BALANCE)
    end
  end
end
