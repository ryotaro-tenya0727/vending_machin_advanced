require './drink'

class VendingMachine

  def initialize
    @quantity_of_coke = 5 # コーラの在庫数
    @quantity_of_diet_coke = 5 # ダイエットコーラの在庫数
    @quantity_of_tea = 5 # お茶の在庫数
    @number_of_100yen = 10 # 100円玉の在庫
    @charge = 0 # お釣り
  end

  def buy(i, kind_of_drink)
    # 100円と500円だけ受け付ける
    if i != 100 && i != 500
      @charge += i
      return nil
    end

    if kind_of_drink == Drink::COKE && @quantity_of_coke == 0
      @charge += i
      return nil
    elsif kind_of_drink == Drink::DIET_COKE && @quantity_of_diet_coke == 0 then
      @charge += i
      return nil
    elsif kind_of_drink == Drink::TEA && @quantity_of_tea == 0 then
      @charge += i
      return nil
    end

    # 釣り銭不足
    if i == 500 && @number_of_100yen < 4
      @charge += i
      return nil
    end

    if i == 100
      @number_of_100yen += 1
    elsif i == 500 then
      # 400円のお釣り
      @charge += (i - 100)
      # 100円玉を釣り銭に使える
      @number_of_100yen -= (i - 100) / 100
    end

    if kind_of_drink == Drink::COKE
      @quantity_of_coke -= 1
    elsif kind_of_drink == Drink::DIET_COKE then
      @quantity_of_diet_coke -= 1
    else
      @quantity_of_tea -= 1
    end

    Drink.new(kind_of_drink)
  end

  def refund
    result = @charge
    @charge = 0
    result
  end

end

