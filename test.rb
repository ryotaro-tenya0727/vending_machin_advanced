require 'test/unit'
require './vending_machine'
require './drink_type'
require './coin'

class VendingMachineTest < Test::Unit::TestCase
  def setup
    @vm = VendingMachine.new
  end

  def test500円でコーラを購入
    drink = @vm.buy(Coin::FIVE_HUNDRED, DrinkType::COKE)
    change = @vm.refund

    assert_equal(DrinkType::COKE, drink.kind)
    assert_equal([Coin::ONE_HUNDRED] * 4, change)
  end

  def test10円ではコーラは買えない
    drink = @vm.buy(10, Drink::COKE)
    change = @vm.refund

    assert_equal(nil, drink)
    assert_equal(10, change)
  end

  def testコーラの在庫が無いときにコーラは買えない
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    drink = @vm.buy(100, Drink::COKE)
    change = @vm.refund

    assert_equal(nil, drink)
    assert_equal(100, change)
  end

  def testダイエットコーラの在庫が無いときにダイエットコーラは買えない
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    drink = @vm.buy(100, Drink::DIET_COKE)
    change = @vm.refund

    assert_equal(nil, drink)
    assert_equal(100, change)
  end

  def testお茶の在庫が無いときにお茶は買えない
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    drink = @vm.buy(100, Drink::TEA)
    change = @vm.refund

    assert_equal(nil, drink)
    assert_equal(100, change)
  end

  def test釣り銭が足りないときにコーラは買えない
    @vm.buy(500, Drink::COKE)
    @vm.refund
    @vm.buy(500, Drink::COKE)
    @vm.refund
    drink = @vm.buy(500, Drink::COKE)
    change = @vm.refund

    assert_equal(nil, drink)
    assert_equal(500, change)
  end

end
