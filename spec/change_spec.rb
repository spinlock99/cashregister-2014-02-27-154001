require 'spec_helper'
require 'change'

describe Change do
  subject(:change) { Change.new(coins: coins) }
  let(:coins)      { [25, 10, 5, 1] }

  describe '#new' do
    specify { expect { change }.to_not raise_error }
    specify { expect { Change.new() }.to raise_error }
    specify { expect { Change.new(coins: [5, 1, 'a', 10]) }.to raise_error }

    it { should eq({25 => 0, 10 => 0, 5 => 0, 1 => 0}) }
  end

  describe '.add' do
    let(:coins) { [10,5,1] }

    specify { expect { change.add(2) }.to raise_error(/not a valid coin/i) }

    it { change.add(5).should eq({10 => 0, 5 => 1, 1 => 0}) }
  end

  describe '.count_coins' do
    its(:count_coins) { should eq(0) }
    it { change.add(5).add(5).count_coins.should eq(2) }
  end

  describe '.value' do
    its(:value) { should eq(0) }
    it { change.add(5).add(5).value.should eq(10) }
  end
end
