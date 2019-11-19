class Oystercard
  attr_reader :balance, :maximum, :in_journey

  MAXIMUM = 90

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @in_journey = false
  end

  def top_up(amount)
    raise "Warning maximum balance is #{@maximum}" if exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def exceeded?(amount)
    (@balance + amount) > @maximum
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
