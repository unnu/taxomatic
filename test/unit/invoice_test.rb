require File.dirname(__FILE__) + '/../test_helper'

class InvoiceTest < Test::Unit::TestCase

  def test_create_from_harvest!
    invoice_wrapper = OpenStruct.new(
      :number => "001122", 
      :amount => 4200,
      :tax => 200
    )
    invoice = ::Invoice.create_from_harvest!(invoice_wrapper)
    assert_equal "001122", invoice.ref_nr
    assert_equal 4200, invoice.amount_gross
    #assert_equal 200, invoice.tax
    #assert_equal 4000, invoice.amount_net
  end
end
