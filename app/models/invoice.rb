class Invoice < Payment

  belongs_to :client
  has_many :reminders
  
  validates_presence_of :client_id

  named_scope :unpaid, :conditions => {:paid_on => nil, :canceled => 0}, :order => 'created_at ASC'
  named_scope :all_for_year, lambda { |year|
    { :conditions => ['YEAR(billed_on) = ?', year], :order => 'billed_on DESC', :include => :client }
  }
  named_scope :without_canceled, :conditions => { :canceled => false }
  
  before_create :hard_code_category_id
  
  def number
    self.ref_nr
  end

  class << self
    def month_selection_field
      'paid_on'
    end
  end

  protected
  
    def hard_code_category_id
      self.expense_category_id = 22
    end
    
end
