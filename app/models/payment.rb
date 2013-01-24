class Payment < ActiveRecord::Base

  TAX_RATES = [0, 7, 16, 19]

  belongs_to :expense_category
  has_one :statement_line
  
  validates_presence_of :amount_gross, :billed_on
  validates_numericality_of :amount_gross
  validates_uniqueness_of :ref_nr, :scope => :type
  validate :amounts_and_tax_calculation_must_be_correct
  validate :dates_must_be_plausible

  # more convenient access
  alias :category :expense_category

  class << self
    # :TODO: performanter mit 1 query, aus der months-range start & end monat extrahieren
    def find_all_by_months(months, year = Time.now.year)
      items = []
      months.each do |month|
        start_date = Time.mktime(year, month)
        end_date   = start_date.end_of_month
        # every child class has a different month_selection_field method 
        f = self.month_selection_field
        condition  = [('%s >= ? AND %s <= ?') % [f, f], start_date, end_date]
        items << self.all(:conditions => condition, :order => f)
      end
      items.flatten
    end
  
    def paid_in_year(year)
      self.all(:conditions => [
          'paid_on >= ? AND paid_on <= ?', 
          Time.utc(year).at_beginning_of_year, 
          Time.utc(year).next_year - 1.day # at_end_of_year not in my rails version
        ],
        :include => :expense_category,
        :order => 'paid_on ASC'
      )
    end
  end
  
  def ust_euro
    "%.2f" % ((amount_gross - amount_net) / 100.to_f)
  end
  
  def amount_net_euro
    "%.2f" % (amount_net / 100.to_f)
  end 
  
  private
  
    def amounts_and_tax_calculation_must_be_correct
      return if [amount_gross, amount_net, tax].any? { |val| val == nil }
      amount_tax = (amount_net * (tax.to_f/100))
      expected_amount_gross = (amount_net + amount_tax).round
      if (amount_gross != expected_amount_gross)
        errors[:base] << "Die Berechnung von Netto-, Bruttobetrag und USt stimmt nicht: (Netto: #{amount_net}, Steuersatz: #{tax}, Steuer: #{amount_tax}, Brutto: #{amount_gross}). Erwartet: #{expected_amount_gross}"
      end
    end
    
    def dates_must_be_plausible
      return if paid_on == nil
      if billed_on > paid_on
          errors[:base] << 'Das Bezahlungs-Datum liegt vor dem Rechnungs-Datum.'
      end
    end
  
  
end
