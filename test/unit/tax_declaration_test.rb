require File.dirname(__FILE__) + '/../test_helper'

class TaxDeclarationTest < Test::Unit::TestCase
  fixtures :tax_declarations

  # Replace this with your real tests.
  def test_truth
    assert_kind_of TaxDeclaration, tax_declarations(:first)
  end
end
