require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < Test::Unit::TestCase
  fixtures :clients

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Client, clients(:first)
  end
end
