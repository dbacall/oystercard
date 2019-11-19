class Oystercard
  attr_reader :balance, :maximum

  MAXIMUM = 90

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  end

  def top_up(amount)
    raise "Warning maximum balance is #{@maximum}" if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    (@balance + amount) > @maximum
  end
end
