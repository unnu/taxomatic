#
# a StatementLine is simply a line from an account, it doesn't show up anywhere on it's own.
# Only when it is converted to an Expense or Invoice it becomes visible in the accounting.
#
class StatementLine < Payment
  
  # this is a must, because the tax rate and thereby the amount_net depends on it.
  # amount_net is calculated when the StatementLine is converted into an expense
  validates_numericality_of :expense_category_id
  
  # this is a (hopefully) unique identifier for this record's source line in outbank
  validates_presence_of :outbank_unique_id
  
  # ensure a 1:1 relation
  validates_uniqueness_of :expense_id
  
  # if there is an expense, this line is used in tax calculation etc.
  # can and will be nil in most cases
  belongs_to :expense, :class_name => 'Expense'
  
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
  
  def has_expense?
    self.expense.present?
  end
  
  def create_expense!
    # transaction do ...
    self.expense = super(
      :billed_on => billed_on, 
      :amount_gross => amount_gross_positive,
      :amount_net => calculate_amount_net(expense_category.default_tax),
      :tax => expense_category.default_tax,
      :expense_category => expense_category,
      :description => description
    )
    save!
  end
  
  def destroy_expense!
    self.expense.destroy
  end
  
  def calculate_amount_net(tax_rate)
    ((Money.new(self.amount_gross) / (100 + tax_rate)) * 100).cents
  end
  
  def amount_gross_positive
    amount_gross < 0 ? amount_gross * -1 : amount_gross
  end
  
end