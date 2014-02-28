class Change < Hash
  def initialize(args)
    raise ArgumentError, 'expecting args[:coins] to be an Array' unless args[:coins].is_a? Array
    raise ArgumentError, 'expecting elements of args[:coins] to be Integers' unless args[:coins].all? { |coin| coin.is_a? Integer }

    args[:coins].each { |coin| self[coin] = 0 }
  end

  def add(coin)
    raise ArgumentError, "#{coin} is not a valid coin in #{self}" unless keys.include?(coin)

    merge(coin => self[coin] + 1)
  end

  def count_coins
    values.reduce(:+)
  end

  def value
    map { |face_value, number_of_coins| face_value * number_of_coins }.reduce(:+)
  end
end
