module EstTaxHelper

  def year_selector(year)
    (2006..Time.now.year).to_a.map do |year|
      link_to year.to_s, {:year => year}, {:class => year.to_s == params[:year] ? 'current' : ''}
    end.join(' ')
  end

  def grouped_and_sorted_expenses
    @expenses.group_by { |expense| expense.category }.sort_by { |cat, exp| cat.name }
  end
end
