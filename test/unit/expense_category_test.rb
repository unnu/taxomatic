require File.dirname(__FILE__) + '/../test_helper'

class ExpenseCategoryTest < Test::Unit::TestCase
  fixtures :expense_categories

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ExpenseCategory, expense_categories(:first)
  end
end
