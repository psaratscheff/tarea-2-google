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

extras3 << ExtraChocolate.new(1000)
extras3 << LowFatMilk.new(400)
extras3 << Cream.new(700)

first_drink = Frappuccino.new(1000, 5, extras1, Chocolate.new(1000, 5, extras2, Cappuccino.new(1000, 5, extras3)))

first_drink.prepare(order)
