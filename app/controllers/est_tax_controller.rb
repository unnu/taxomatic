class EstTaxController < ApplicationController

  def index
    @year           = params['year'] || 2006

    @invoices       = Invoice.paid_in_year(@year)
    @total_invoices = @invoices.inject(0) { |sum, invoice| sum += invoice.amount_net }

    @expenses       = Expense.paid_in_year(@year)
    @total_expenses = @expenses.reject(&:amortization?).inject(0) { |sum, expense| sum += expense.amount_net }
  end

end
