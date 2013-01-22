class Client < ActiveRecord::Base
  
  validates_uniqueness_of :id, :name
  validates_numericality_of :harvest_client_id, :allow_nil => true
  
  has_many :invoices
  has_many :websites
  
  scope :active, :conditions => {:is_active => true}, :order => :name
  
  # if you're strict you'll complain ... this is view code.
  # alternatives: helper; TextHelper#simple_format
  def address
    read_attribute(:address).gsub("\n", "<br />")
  end
  
  def address_plain
    read_attribute(:address)
  end

end
