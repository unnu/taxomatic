require 'test_helper'
require 'ostruct'

class StatementLineTest < ActiveSupport::TestCase

  def setup
    ExpenseCategory.delete_all
    ExpenseCategory.create!(:name => 'Bankgebühren', :default_tax => 19)
  end

  def valid_attributes
    {
      :amount_gross => 119,
      :billed_on => Date.parse("2012-08-16"),
      :description => "Invoice description",
      :expense_category_id => ExpenseCategory.first.id,
      :outbank_unique_id => 4242
    }
  end
  
  def test_create_from_outbank_line
    outbank_line = OpenStruct.new(
      :amount => 4760,
      :booked_on => Date.parse("2012-08-16"),
      :category => "Bankgebühren",
      :description => 'Invoice description',
      :unique_id => "40206a5df6a6372c952e2402b96c3f64"
    )
    line = StatementLine.create_from_outbank_line!(outbank_line)
    assert_equal 4760, line.amount_gross
    assert_equal Date.parse("2012-08-16"), line.billed_on
    assert_equal ExpenseCategory.find_by_name('Bankgebühren'), line.category
    assert_equal 'Invoice description', line.description
    assert_equal "40206a5df6a6372c952e2402b96c3f64", line.outbank_unique_id
  end
  
  def test_must_have_expense_category
    attributes = valid_attributes.dup
    attributes.delete(:expense_category_id)
    line = StatementLine.new(attributes)
    assert !line.valid?
    assert_equal ["ist keine Zahl"], line.errors[:expense_category_id]
  end

  def test_create_expense
    line = StatementLine.create!(valid_attributes)
    assert_nil line.expense
    line.create_expense!
    assert_not_nil line.expense
    assert_not_nil line.expense_id
  end

  def test_has_expense
    line = StatementLine.create!(valid_attributes)
    assert !line.has_expense?
    line.create_expense!
    assert line.has_expense?
  end
  
  def test_destroy_expense
    line = StatementLine.create!(valid_attributes)
    line.create_expense!
    assert_not_nil line.expense
    line.destroy_expense!
    line.reload
    assert_nil line.expense
  end
  
end
