# encoding: utf-8
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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
  
  def group_by_month(payments)
    payments.group_by { |p| p.billed_on.month }
  end

end
