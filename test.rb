require 'test/unit'
require './vending_machine'
require './drink'

class VendingMachineTest < Test::Unit::TestCase
  def setup
    @vm = VendingMachine.new()
  end

  def test500円でコーラを購入
    drink = @vm.buy(500, Drink::COKE)
    charge = @vm.refund()

    assert_equal(Drink::COKE, drink.kind())
    assert_equal(400, charge)
  end

  def test10円ではコーラは買えない
    drink = @vm.buy(10, Drink::COKE)
    charge = @vm.refund()

    assert_equal(nil, drink)
    assert_equal(10, charge)
  end

  def testコーラの在庫が無いときにコーラは買えない
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    @vm.buy(100, Drink::COKE)
    drink = @vm.buy(100, Drink::COKE)
    charge = @vm.refund()

    assert_equal(nil, drink)
    assert_equal(100, charge)
  end

  def testダイエットコーラの在庫が無いときにコーラは買えない
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    @vm.buy(100, Drink::DIET_COKE)
    drink = @vm.buy(100, Drink::DIET_COKE)
    charge = @vm.refund()

    assert_equal(nil, drink)
    assert_equal(100, charge)
  end

  def testお茶の在庫が無いときにコーラは買えない
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    @vm.buy(100, Drink::TEA)
    drink = @vm.buy(100, Drink::TEA)
    charge = @vm.refund()

    assert_equal(nil, drink)
    assert_equal(100, charge)
  end

  def test釣り銭が足りないときにコーラは買えない
    @vm.buy(500, Drink::COKE)
    @vm.refund()
    @vm.buy(500, Drink::COKE)
    @vm.refund()
    drink = @vm.buy(500, Drink::COKE)
    charge = @vm.refund()

    assert_equal(nil, drink)
    assert_equal(500, charge)
  end

end

