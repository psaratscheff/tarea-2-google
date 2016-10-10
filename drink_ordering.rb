require 'byebug'
class Order
  attr_accessor :time
  attr_accessor :time_multiplier
  attr_accessor :price
  attr_accessor :customer_name
  attr_accessor :espressoed
  attr_accessor :macchiato_fail

  def initialize(customer_name)
    @time = 0
    @time_multiplier = 1
    @price = 0
    @customer_name = customer_name
    @espressoed = false
    @macchiato_fail = false
  end

  def finish
    return false if macchiato_fail && rand < 0.1
    @time *= @time_multiplier
    puts "\n\nLuego de #{@time} minutos...\n\n#{@customer_name}, tu orden "\
    "esta lista. \nPrecio: #{@price}"
    true
  end
end

class Extra
  def initialize(price)
    @price = price
  end

  def add_extra(order, drink_name)
    order.price += @price
  end
end

class WholeMilk < Extra
  def add_extra(order, drink_name)
    @price -= 200
    super
  end
end

class LowFatMilk < Extra
end

class SoyMilk < Extra
  def add_extra(order, drink_name)
    @price += 300
    super
  end
end

class Cream < Extra
  def add_extra(order, drink_name)
    order.customer_name = aestheticize(order.customer_name)
    super
  end

  private

  def aestheticize(str)
    ret = ''
    str.chars.each do |c|
      ret << c + ' '
    end
    ret.chop
  end
end

class IceCream < Extra
  def add_extra(order, drink_name)
    @price = rand > 0.5 ? @price + 100 : @price + 500
    super
  end
end

class ExtraChocolate < Extra
  def add_extra(order, drink_name)
    @price += 200 unless drink_name == 'Chocolate'
    super
  end
end

class Drink
  def initialize(price, prep_time, extras, next_drink = nil)
    @price = price
    @prep_time = prep_time
    @extras = extras
    @next = next_drink
  end

  def prepare(order)
    order.price += @price
    order.time += @prep_time
    add_extras order
    if @next
      @next.prepare(order)
    else
      order.finish
    end
  end

  private

  def add_extras(order)
    @extras.each do |e|
      e.add_extra(order, self.class.name)
    end
  end
end

class Espresso < Drink
  def prepare(order)
    order.time_multiplier *= 0.8 unless order.espressoed
    order.espressoed = true
    super
  end
end

class Cappuccino < Drink
  def prepare(order)
    @price += 100 * @extras.count
    super
  end
end

class Frappuccino < Drink
  def prepare(order)
    @price *= 1 + @extras.count * 0.05
    super
  end
end

class Macchiato < Drink
  def prepare(order)
    order.macchiato_fail = true
    super
  end
end

class Tea < Drink
end

class Chocolate < Drink
  def prepare(order)
    order.customer_name = order.customer_name.upcase
    super
  end
end
