#
# a StatementLine is simply a line from an account, it doesn't show up anywhere on it's own.
# Only when it is converted to an Expense or Invoice it becomes visible in the accounting.
#
class StatementLine < Payment
  class << self
    def create_from_outbank_line!(line)
      self.create!(
        # these are calculated when the StatementLine is converted to an expense
        :amount_net => nil, 
        :tax => nil, 
        :amount_gross => line.amount,
        :billed_on => line.booked_on,
        :description => line.description,
        :expense_category => ExpenseCategory.find_by_name(line.category)
      )
    end
  end
end