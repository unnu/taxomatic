require 'test_helper'

class TaxCalculatorTest < ActiveSupport::TestCase

  #
  # #net_from_gross
  #
  test "#net_from_gross in the easiest case" do
    gross    = 119
    tax_rate = 19
    expected = 100
    assert_equal expected, TaxCalculator.net_from_gross(gross, tax_rate)
  end
  
  test "#net_from_gross when calculating with cent fractions" do
    gross    = 100
    tax_rate = 19
    expected = 84
    assert_equal expected, TaxCalculator.net_from_gross(gross, tax_rate)
  end
  
  test "#net_from_gross when calculating with small cent fractions" do
    gross    = 1
    tax_rate = 19
    expected = 1 # the tax portion of the gross amount rounds to less than a cent, so it doesn't become visible.
    assert_equal expected, TaxCalculator.net_from_gross(gross, tax_rate)
  end
  
  test "#net_from_gross when calculating with smaller cent fractions" do
    gross    = 13
    tax_rate = 19
    expected = 11
    assert_equal expected, TaxCalculator.net_from_gross(gross, tax_rate)
  end
  
  test "#net_from_gross when calculating with tax_rate of 0" do
    gross    = 100
    tax_rate = 0
    expected = 100
    assert_equal expected, TaxCalculator.net_from_gross(gross, tax_rate)
  end


  #
  # #gross_from_net
  #
  test "#gross_from_net in the easiest case" do
    net      = 100
    tax_rate = 19
    expected = 119
    assert_equal expected, TaxCalculator.gross_from_net(net, tax_rate)
  end

  test "#gross_from_net when calculating with cent fractions" do
    net      = 84
    tax_rate = 19
    expected = 100
    assert_equal expected, TaxCalculator.gross_from_net(net, tax_rate)
  end
  
  test "#gross_from_net when calculating with small cent fractions" do
    net      = 0
    tax_rate = 19
    expected = 0
    assert_equal expected, TaxCalculator.gross_from_net(net, tax_rate)
  end
  
  test "#gross_from_net when calculating with smaller cent fractions" do
    net      = 11
    tax_rate = 19
    expected = 13
    assert_equal expected, TaxCalculator.gross_from_net(net, tax_rate)
  end
  
  
  test "#gross_from_net when calculating with tax_rate of 0" do
    net      = 100
    tax_rate = 0
    expected = 100
    assert_equal expected, TaxCalculator.gross_from_net(net, tax_rate)
  end

end
