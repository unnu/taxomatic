class Invoice < Payment

  belongs_to :client
  
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
        :amount_net => (api_object.amount_gross / (100 + api_object.tax_rate)) * 100  ,
        :billed_on => api_object.issued_at,
        # currently only paid invoices are imported
        :paid_on => api_object.issued_at,
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
