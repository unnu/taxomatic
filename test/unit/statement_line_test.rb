require 'test_helper'
require 'ostruct'

class StatementLineTest < ActiveSupport::TestCase

  def setup
    ExpenseCategory.delete_all
    ExpenseCategory.create!(:name => 'Bankgebühren')
  end
  
  def test_create_from_outbank_line
    outbank_line = OpenStruct.new(
      :amount => 4760,
      :booked_on => Date.parse("2012-08-16"),
      :category => "Bankgebühren",
      :description => 'Invoice description'
    )
    line = StatementLine.create_from_outbank_line!(outbank_line)
    assert_equal 4760, line.amount_gross
    assert_equal Date.parse("2012-08-16"), line.billed_on
    assert_equal ExpenseCategory.find_by_name('Bankgebühren'), line.category
    assert_equal 'Invoice description', line.description
  end
  
  def test_must_have_expense_category
    attributes = {
      :amount_gross => 42,
      :billed_on => Date.parse("2012-08-16"),
      :description => "Invoice description"
    }
    line = StatementLine.new(attributes)
    line.valid?
    assert_equal ["ist keine Zahl"], line.errors[:expense_category_id]
  end
  
end
