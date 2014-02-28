class CashRegister
  attr_reader :coins

  def initialize(args={coins: [25,10,5,1]})
    self.coins = args[:coins]
  end

  def coins=(coins)
    validate_integer_array(coins)
    @coins = coins
    @optimal_change = Hash.new do |optimal_change, amount|
      optimal_change[amount] = get_optimal_change(amount)
    end
  end

  def make_change(amount)
    @optimal_change[amount]
    return(@optimal_change[amount])
  end

  private

  def get_optimal_change(amount)
    if amount < @coins.min
      nil
    elsif @coins.include?(amount)
      Change.new(coins: @coins).add(amount)
    else
      @coins.select do |coin|
        coin <= amount
      end.map do |coin|
        @optimal_change[amount - coin] ? @optimal_change[amount - coin].add(coin) : nil
      end.compact.select do |change|
        change.value == amount
      end.min { |a, b| a.count_coins <=> b.count_coins }
    end
  end

  def validate_integer_array(array)
    raise ArgumentError, "Expected Array got #{array.class}" unless array.is_a? Array
    raise ArgumentError, "Array elements must be Integers" unless array.all? { |e| e.is_a? Integer }
  end
end
