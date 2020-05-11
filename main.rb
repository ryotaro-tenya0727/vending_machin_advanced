require './drink'
require './vending_machine'

vm = VendingMachine.new()

drink = vm.buy(500, Drink::COKE)
charge = vm.refund()

if drink != nil && drink.kind() == Drink::COKE then
  print "コーラを購入しました。"
  print "お釣りは#{charge}です"
else
  raise StandardError.new("コーラ買えんかった(´ﾟдﾟ｀)")
end

