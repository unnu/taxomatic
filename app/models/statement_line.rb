#
# a StatementLine type Payment is simply an entry from an account,
# it doesn't show up anywhere on it's own
# Only when it is converted to an Expense or Invoice it becomes visible in the 
# accounting.
#
class StatementLine < Payment
  class << self
    def create_from_outbank_line!(line)
      self.create!(
        :amount_net => nil, 
        :tax => nil, 
        :amount_gross => line.amount,
         # TODO verify if this is the correct date to use.  
        :billed_on => line.booked_on,
        :description => line.description,
        # TODO expensecategory must be present as fixture of course.
        :expense_category => ExpenseCategory.find_by_name(line.category)
      )
    end
  end
end