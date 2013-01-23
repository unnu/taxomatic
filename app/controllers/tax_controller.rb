class TaxController < ApplicationController

  before_filter :make_date_from_params, :only => :ust
  
  def ust
    @invoices = Invoice.find_all_by_months([@date.month], @date.year)
    @expenses = Expense.find_all_by_months([@date.month], @date.year)
    
    @invoices_net_sum = sum_amount_net(@invoices)
    @invoices_ust_sum = sum_ust(@invoices)
    
    @expenses_net_sum = sum_amount_net(@expenses)
    @expenses_ust_sum = sum_ust(@expenses)      
  end
  
  private
  
    def sum_amount_net(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.amount_net_euro.to_f) }
    end
    
    def sum_ust(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.ust_euro.to_f) }
    end
    
    def make_date_from_params
      month = (params[:month] || Date.today.month).to_i
      year = (params[:year] || Date.today.year).to_i
      @date = Date.new(year, month)
    end
  
end
