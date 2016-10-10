require_relative 'drink_ordering.rb'
require 'byebug'

order = Order.new('Homer Simpson')

extras1 = []
extras2 = []
extras3 = []

extras1 << SoyMilk.new(500)
extras1 << Cream.new(700)

extras2 << WholeMilk.new(400)
extras2 << ExtraChocolate.new(1000)
extras2 << IceCream.new(500)

extras3 << ExtraChocolate.new(1000)
extras3 << LowFatMilk.new(400)
extras3 << Cream.new(700)

first_drink = Tea.new(2000, 5, extras1, Tea.new(1700, 7, extras2, Tea.new(1800, 4, extras3)))

first_drink.prepare(order)
