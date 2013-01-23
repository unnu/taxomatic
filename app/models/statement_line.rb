#
# a StatementLine is simply a line from an account, it doesn't show up anywhere on it's own.
# Only when it is converted to an Expense or Invoice it becomes visible in the accounting.
#
class StatementLine < Payment
  
  # this is a must, because the tax rate and thereby the amount_net depends on it.
  # amount_net is calculated when the StatementLine is converted into a payment
  validates_numericality_of :expense_category_id
  
  # this is a (hopefully) unique identifier for this record's source line in outbank
  validates_presence_of :outbank_unique_id
  
  class << self
    def create_from_outbank_line!(line)
      self.create!(
        # these are calculated when the StatementLine is converted to an expense
        :amount_net => nil, 
        :tax => nil, 
        :amount_gross => line.amount,
        :billed_on => line.booked_on,
        :description => line.description,
        :expense_category => ExpenseCategory.find_by_name(line.category),
        :outbank_unique_id => line.unique_id
      )
    end
  end
  
end