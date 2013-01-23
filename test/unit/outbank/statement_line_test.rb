require 'test_helper'

require 'ostruct'

class Outbank::StatementLineTest < Test::Unit::TestCase
  
  def setup
    csv = Outbank::StatementImport.new('test/fixtures/outbank-fixture.csv').csv
    @csv_rows = csv.read
  end
  
  def test_attribute_mapping_works
    line = Outbank::StatementLine.new(@csv_rows[0])
    assert_equal nil, line.description2
    assert_equal "EUR", line.currency
    assert_equal -1500, line.amount
    assert_equal Date.parse("31.12.2012"), line.booked_on
    assert_equal Date.parse("02.01.2013"), line.valuta_on
    assert_equal nil, line.recipient
    assert_equal nil, line.bank_code
    assert_equal nil, line.account_number
    assert_equal "Saldo der Abschlussposten QM - Support 04082 Leipzig", line.description
    assert_equal "Bankgebühren", line.category
  end
end