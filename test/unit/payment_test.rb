require File.dirname(__FILE__) + '/../test_helper'

class PaymentTest < Test::Unit::TestCase

  def test_validate_tax_calculation_ok
    payment = Payment.new(
      :amount_net => 100,
      :amount_gross => 119,
      :tax => 19
    )
    payment.valid? 
    assert_equal nil, payment.errors[:base]
  end

  def test_validate_tax_calculation_ok_2
    payment = Payment.new(
      :amount_net => 101,
      :amount_gross => 120,
      :tax => 19
    )
    payment.valid? 
    assert_equal nil, payment.errors[:base]
  end

  def test_validate_tax_calculation_invalid
    payment = Payment.new(
      :amount_net => 100,
      :amount_gross => 100,
      :tax => 19
    )
    assert_equal false, payment.valid? 
    assert_equal "Die Berechnung von Netto-, Bruttobetrag und USt stimmt nicht.", payment.errors[:base]
  end
end