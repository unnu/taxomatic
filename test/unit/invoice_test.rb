require 'test_helper'

class InvoiceTest < Test::Unit::TestCase

  def setup
    Client.delete_all
    @client = Client.create!(:name => 'Hans', :harvest_client_id => 42)
  end
  
  def test_create_from_harvest!
    invoice_wrapper = OpenStruct.new(
      :number => "001122", 
      :amount_gross => 4760,
      :amount_net => 4000,
      :tax_rate => "19",
      :tax_amount => "200",
      :issued_at => "2012-08-16",
      :client_id => 42,
      :subject => 'Invoice text'
    )
    invoice = ::Invoice.create_from_harvest!(invoice_wrapper)
    assert_equal "001122", invoice.ref_nr
    assert_equal 4000, invoice.amount_net
    assert_equal 4760, invoice.amount_gross
    assert_equal 19, invoice.tax
    assert_equal Date.parse("2012-08-16"), invoice.billed_on
    assert_equal @client, invoice.client
    assert_equal "Invoice text", invoice.description
    assert_equal 0, invoice.canceled
  end
end
