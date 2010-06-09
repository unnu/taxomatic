require File.dirname(__FILE__) + '/../test_helper'

class InvoiceTest < Test::Unit::TestCase

  fixtures :payments

  # Replace this with your real tests.
  def test_basics

    self.use_instantiated_fixtures = false

    assert_equal 2, Invoice.count
    assert_kind_of Invoice, payments(:same_year_invoice)
    # instantiated fixtures dont work for some reason
    #assert_kind_of Invoice, @same_year_invoice
    assert_equal '2006-12-10', payments(:same_year_invoice).billed_on.to_s
  end

  def test_invoice_nr_generation_same_year
    assert_equal '01306', Invoice.new.number
  end

  def test_invoice_nr_generation_new_year
    # delete all this years' invoices
    Invoice.find(1).destroy
    assert_equal '00106', Invoice.new.number
  end
end
