class Domain < ActiveRecord::Base

  belongs_to :website
  
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-z0-9.-]+\.[a-z]{2,4}$/
  validates_numericality_of :website_id

  def cost
    name =~ /\.([a-z]{2,4})$/
    # $1 ist first regex match 
    if DOMAIN_FEES[$1.to_sym].nil?
      raise "Unknown TLD '%s', please update the DOMAIN_FEES lookup hash" % $1
    end
    DOMAIN_FEES[$1.to_sym]
  end

  def cost_per_year
    cost * 12
  end

end
