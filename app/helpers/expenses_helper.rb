module ExpensesHelper

  def year_selector
    Expense.find_years_with_expenses.map do |y| 
      text = (y == params[:year]) ? "<b>#{y}</b>".html_safe : y
      link_to(text, expenses_for_year_path(:year => y)).html_safe
    end.join(' ').html_safe
  end
  
  def expenses_grouped_by_quarter(expenses)
    # don't group if we're showing all years, doesn't make sense
    params[:year] != 'all' ? expenses.group_by { |e| e.billed_in_quarter } : { nil => expenses }
  end
  
end
