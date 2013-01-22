module InvoicesHelper

  def year_selector
    current_year = Date.today.year
    ((current_year-5)..(current_year)).to_a.map do |y| 
      text = (y == params[:year].to_i) ? "<b>#{y}</b>".html_safe : y
      link_to(text, invoices_for_year_path(:year => y)).html_safe
    end.join(' ').html_safe
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
