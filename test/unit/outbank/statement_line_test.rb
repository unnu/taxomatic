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

  #
  # Unique Is
  #
  def test_unique_id_exists
    row = @csv_rows[0]
    line = Outbank::StatementLine.new(row)
    assert_equal "40206a5df6a6372c952e2402b96c3f64", line.unique_id
  end

  def test_unique_id_depends_on_amount
    row = @csv_rows[0]
    line = Outbank::StatementLine.new(row)
    row['Betrag'] = "1#{row['Betrag']}"
    assert_not_equal Outbank::StatementLine.new(row), line.unique_id
  end
  
  def test_unique_id_depends_on_booked_on
    row = @csv_rows[0]
    line = Outbank::StatementLine.new(row)
    row['Buchungstag'] = "01.01.1971"
    assert_not_equal Outbank::StatementLine.new(row), line.unique_id
  end
  
  def test_unique_id_depends_on_description
    row = @csv_rows[0]
    line = Outbank::StatementLine.new(row)
    row['Verwendungszweck'] = "#{row['Verwendungszweck']} Bla bla"
    assert_not_equal Outbank::StatementLine.new(row), line.unique_id
  end
end