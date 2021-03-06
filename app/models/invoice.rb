class Invoice < Payment

  belongs_to :client
  
  validates_numericality_of :amount_net, :only_integer => true
  validates_inclusion_of :tax, :in => TAX_RATES
  validates_presence_of :client_id

  scope :unpaid, :conditions => {:paid_on => nil, :canceled => 0}, :order => 'created_at ASC'
  scope :all_for_year, lambda { |year|
    { :conditions => ['YEAR(billed_on) = ?', year], :order => 'billed_on DESC', :include => :client }
  }
  scope :without_canceled, :conditions => { :canceled => false }
  
  before_create :hard_code_category_id
  
  def number
    self.ref_nr
  end

  class << self
    def month_selection_field
      'paid_on'
    end
    
    def create_from_harvest!(api_object)
      self.create!(
        :ref_nr => api_object.number,
        :amount_gross => api_object.amount_gross,
        :amount_net => api_object.amount_net,
        :billed_on => api_object.issued_at,
        :paid_on => (api_object.paid? ? api_object.issued_at : nil),
        :description => api_object.subject,
        :client => Client.find_by_harvest_client_id(api_object.client_id),
        :tax => api_object.tax_rate
      )
    end
  end

  protected
  
    def hard_code_category_id
      self.expense_category_id = 22
    end
    
end
