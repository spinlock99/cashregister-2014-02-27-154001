require 'spec_helper'
require 'cashregister'
require 'change'
require 'its'

describe CashRegister do
  subject(:cash_register) { CashRegister.new(coins: coins) }
  let(:coins)             { [25, 10, 5, 1] }

  describe "new" do
    it "should instantiate" do
      lambda { cash_register }.should_not raise_exception
    end
    specify { expect { CashRegister.new }.to_not raise_error }

    specify { expect { CashRegister.new(coins: 10) }.to raise_error(/expected array/i) }
    specify do
      expect { CashRegister.new(coins: [10, 1, 's', 25]) }.to raise_error(/must be integer/i)
    end
  end

  describe '.make_change' do
    its(:make_change, 0)   { should eq(nil) }
    its(:make_change, 5)   { should eq( { 25 => 0, 10 => 0, 5 => 1, 1 => 0}) }
    its(:make_change, 6)   { should eq( { 25 => 0, 10 => 0, 5 => 1, 1 => 1}) }
    its(:make_change, 123) { should eq( { 25 => 4, 10 => 2, 5 => 0, 1 => 3}) }
    it 'handles crazy foreign coins' do
      CashRegister.new(coins: [10,7,1]).make_change(14).should eq({10 => 0, 7 => 2, 1 => 0})
    end
    it 'handles complex cases' do
      CashRegister.new(coins: [2,5,12,18,35,36]).make_change(67).
        should eq({2=>1, 5=>0, 12=>1, 18=>1, 35=>1, 36=>0})
    end
  end
end
