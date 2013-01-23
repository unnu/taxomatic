require 'test_helper'

class ExpenseTest < Test::Unit::TestCase
  
  def attributes
    {"tax"=>19,
     "amount_net"=>1378,
     "billed_on"=> Time.now - 1.day,
     "canceled" => false,
     "client_id"=>nil,
     "tax_declaration_id"=>nil,
     "ref_nr"=>"n.a. (Woolworth)",
     "description"=>"Order,Register,PostIts",
     "paid_on"=>nil,
     "amount_gross"=>1640,
     "expense_category_id"=>15
     }  
  end
  
  def test_expense_should_generate_unique_ref_nr_if_none_given
    expense = Expense.create!(attributes.merge!({:ref_nr => nil}))
    assert_not_nil expense.ref_nr
  end
  
  def test_expense_should_preserve_ref_nr_if_none_given
    ref_nr = Time.now.to_i
    expense = Expense.create!(attributes.merge!({:ref_nr => ref_nr}))
    assert_equal ref_nr, expense.ref_nr
  end
  
  def test_billed_on
    months_and_quarters = {
      1 => 1,
      2 => 1,
      3 => 1,
      4 => 2,
      5 => 2,
      6 => 2,
      7 => 3,
      8 => 3,
      9 => 3,
      10 => 4,
      11 => 4,
      12 => 4
    }
    months_and_quarters.each do |month, quarter|
      e = Expense.new(:billed_on => Time.parse("2008-#{month}-01"))
      assert_equal quarter, e.billed_in_quarter, "Expected Month #{month} to be in Quarter #{quarter}"
    end
  end
  
  def x_test_create_from_outbank_statement_line
    line =
    expense = Expense.create_from_outbank_statement_line!(line)
    
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
