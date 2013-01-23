class TaxDeclaration
  
  def self.for_date(date)
    new(date)
  end
  
  def initialize(date)
    @date = date
  end
  
  def invoices
    @invoices ||= Invoice.find_all_by_months([@date.month], @date.year)
  end
  
  def expenses
    @expenses ||= Expense.find_all_by_months([@date.month], @date.year)
  end
  
  def net_earnings
    sum_amount_net(invoices)
  end
  
  def tax_on_invoices
    sum_ust(invoices)
  end
  
  def net_expenses
    sum_amount_net(expenses)
  end
  
  def tax_on_expenses
    sum_ust(expenses)
  end
  
  def tax_due
    tax_on_invoices - tax_on_expenses
  end
  
  private
  
    def sum_amount_net(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.amount_net_euro.to_f) }
    end
    
    def sum_ust(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.ust_euro.to_f) }
    end
  
end
