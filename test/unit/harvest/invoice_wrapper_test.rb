require 'test_helper'

require 'ostruct'

class Harvest::InvoiceWrapperTest < Test::Unit::TestCase

  def test_to_money_conversion_with_integer_amount
    api_object = OpenStruct.new(:amount => "42")
    assert_equal 4200, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end

  def test_to_money_conversion_with_one_digit
    api_object = OpenStruct.new(:amount => "42.1")
    assert_equal 4210, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end
  
  def test_to_money_conversion_with_one_digit_which_is_zero
    api_object = OpenStruct.new(:amount => "42.0")
    assert_equal 4200, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end

  def test_to_money_conversion_with_two_digits
    api_object = OpenStruct.new(:amount => "42.15")
    assert_equal 4215, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end
  
  def test_to_money_conversion_with_two_digits_and_zero
    api_object = OpenStruct.new(:amount => "42.10")
    assert_equal 4210, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end
  
  def test_to_money_conversion_with_negative_number
    api_object = OpenStruct.new(:amount => "-42.10")
    assert_equal -4210, Harvest::InvoiceWrapper.new(api_object).amount_gross
  end
  
  def test_amount_net
    api_object = OpenStruct.new(:amount => "42.10", :tax_amount => "2.10")
    assert_equal 4000, Harvest::InvoiceWrapper.new(api_object).amount_net
  end

  def test_paid_state
    api_object = OpenStruct.new(:state => "paid")
    assert_equal true, Harvest::InvoiceWrapper.new(api_object).paid?
  end
  
  def test_not_paid_state
    api_object = OpenStruct.new(:state => "open")
    assert_equal false, Harvest::InvoiceWrapper.new(api_object).paid?
  end
  
  def test_client_id
    api_object = OpenStruct.new(:client_id => "12345")
    assert_equal 12345, Harvest::InvoiceWrapper.new(api_object).client_id
  end
  
  def test_valid_tax_rate
    api_object = OpenStruct.new(:tax => "19.0")
    assert_equal 19, Harvest::InvoiceWrapper.new(api_object).tax_rate
  end
  
  def test_invalid_tax_rate
    api_object = OpenStruct.new(:tax => "42.0")
    assert_raise(StandardError) { Harvest::InvoiceWrapper.new(api_object).tax_rate }
  end
  
  def test_ref_nr
    api_object = OpenStruct.new(:number => "00712")
    assert_equal "00712", Harvest::InvoiceWrapper.new(api_object).ref_nr
  end
  
  def test_amount_tax
    api_object = OpenStruct.new(:tax_amount => "42.01")
    assert_equal 4201, Harvest::InvoiceWrapper.new(api_object).amount_tax
  end
end
