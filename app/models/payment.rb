class Payment < ActiveRecord::Base

  belongs_to :expense_category

  validates_uniqueness_of :id
  validates_uniqueness_of :ref_nr, :allow_nil => true
  validates_presence_of :amount_net, :amount_gross, :tax, :amount_net, :billed_on
  validates_numericality_of :amount_net, :amount_gross, :tax
  validates_inclusion_of :tax, :in => [0, 7, 16, 19]

  # more convenient access (shorter name)
  alias :category :expense_category
  
  # :TODO: did not work as fix for "id already exists" bug
  def before_validation
    @ref_nr = nil if @ref_nr == ''
  end
  
  def validate
    validate_tax_calculation
    validate_dates_plausibility
  end
  
  # zusammenhang von netto, brutto & ust-satz checken.
  def validate_tax_calculation
    return if [amount_gross, amount_net, tax].any? { |val| val == nil }
    #logger.debug("%s %s %s %s" % [amount_gross, amount_net, (1 + tax.to_f/100), (amount_net * (1 + tax.to_f/100))])
    if amount_gross != (amount_net * (1 + tax.to_f/100)).round
        errors.add_to_base('Die Berechnung von Netto-, Bruttobetrag und USt stimmt nicht.')
    end   
  end
  
  # bezahlt datum muss nach dem erstell-datum liegen
  def validate_dates_plausibility
    return if paid_on == nil
    if billed_on > paid_on
        errors.add_to_base('Das Bezahlungs-Datum liegt vor dem Rechnungs-Datum.')
    end
  end
  
  class << self
    # :TODO: performanter mit 1 query, aus der months-range start & end monat extrahieren
    def find_all_by_months(months, year = Time.now.year)
      items = []
      months.each do |month|
        logger.debug(">>>>>>>>> #{year} #{month}")
        start_date = Time.mktime(year, month)
        end_date   = start_date.end_of_month
        # every child class has a different month_selection_field method 
        f = self.month_selection_field
        condition  = [('%s >= ? AND %s <= ?') % [f, f], start_date, end_date]
        items << self.find(:all, :conditions => condition, :order => f)
      end
      items.flatten
    end
  
    def paid_in_year(year)
      find(:all, 
        :conditions => [
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
  
end
