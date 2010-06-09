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
    # being pragmatic. this would be cleanest in a model
    [
      ['--- Bitte waehlen ---', nil],
      ['19%', 19],
      ['16%', 16],
      ['7%', 7],
      ['0%', 0]
    ]
  end

end