require File.dirname(__FILE__) + '/../../test_helper'

require 'ostruct'

class Outbank::StatementLineTest < Test::Unit::TestCase
  def test_attribute_mapping_works
    line = Outbank::StatementLine.new
  end
end