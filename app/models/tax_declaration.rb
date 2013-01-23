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
  
  def invoices_net_sum
    sum_amount_net(invoices)
  end
  
  def invoices_ust_sum
    sum_ust(invoices)
  end
  
  def expenses_net_sum
    sum_amount_net(expenses)
  end
  
  def expenses_ust_sum
    sum_ust(expenses)
  end
  
  def tax_due
    invoices_ust_sum - expenses_ust_sum
  end
  
  private
  
    def sum_amount_net(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.amount_net_euro.to_f) }
    end
    
    def sum_ust(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.ust_euro.to_f) }
    end
  
end
