require File.dirname(__FILE__) + '/../test_helper'

class ReminderTest < Test::Unit::TestCase
  fixtures :reminders

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Reminder, reminders(:first)
  end
end
