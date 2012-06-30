module InvoicesHelper

  def year_selector
    Invoice.find_years_with_expenses.map do |y| 
      text = (y == params[:year]) ? "<b>#{y}</b>" : y
      link_to(text, expenses_for_year_path(:year => y))
    end.join(' ')
  end
  
  def row_css(invoice, last_month, last_year)
    klass = []
    if (invoice.billed_on.year != last_year)
      klass << 'new_year'
    elsif (invoice.billed_on.month != last_month)
      klass << 'new_month'
    end
    klass << 'canceled' if invoice.canceled?
    (' class="%s"' % klass.join(' ')) unless klass.empty?
  end
  
  def active_clients_select_tag
    collection_select('invoice', :client_id, Client.active, :id, :name)
  end
  
end
