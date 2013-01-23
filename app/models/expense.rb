require 'digest'

class Expense < Payment

  validates_presence_of :expense_category_id
  belongs_to :expense_category
   
  scope :all_for_year, lambda { |year|
    { :conditions => ['YEAR(billed_on) = ?', year], :order => 'billed_on DESC', :include => :expense_category }
  }

  before_create :generate_ref_nr, :if => lambda { |expense| expense.ref_nr.nil? }
  
  class << self
    
    def month_selection_field
      'billed_on'
    end
    
    def find_years_with_expenses 
      find_by_sql('SELECT DISTINCT YEAR(billed_on) AS year from payments WHERE type="Expense" ORDER BY year').map(&:year)
    end
    
    def create_from_outbank_statement_line!(line)
      p line
    end

  end

  # an expense is an amortization when it is more expensive than 410 euro net 
  # and in a category which can have amortizations.
  def amortization?
    amount_net >= 41000 && category.amortization?
  end
  
  # which quarter of the year was this expense billed in?
  def billed_in_quarter
    (billed_on.month.to_f / 3).ceil
  end

  private
  
    def generate_ref_nr
      self.ref_nr = Digest::MD5.hexdigest(Time.now.to_s)[0, 5]
    end
end
