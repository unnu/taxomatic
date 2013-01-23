class Client < ActiveRecord::Base
  
  validates_uniqueness_of :id, :name, :harvest_client_id
  validates_numericality_of :harvest_client_id, :allow_nil => true
  
  has_many :invoices
  
  scope :active, :conditions => {:is_active => true}, :order => :name
  
end
