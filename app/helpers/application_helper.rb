# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def format_dmy(date)
    date.strftime('%d.%m.%Y') if date != nil
  end
  
  def format_dm(date)
    date.strftime('%d.%m.') if date != nil
  end

  def format_euro(amount)
    ('%.2f' % (amount.to_f / 100)).to_s.sub('.', ',')
  end

  def tax_options
    options = [['Steuersatz wählen ...', nil]]
    Payment::TAX_RATES.each { |rate| options << ["#{rate}%", rate] }
    options
  end

end