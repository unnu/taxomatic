class Website < ActiveRecord::Base

  belongs_to :client
  has_many :domains
  #has_many :invoices

  def hosting_fee_per_year
    hosting_fee * 12
  end

  def domain_costs_per_year
    domains.reject {|d| d.is_free }.inject(0) { |total_cost, d| total_cost + d.cost_per_year }
  end

  def total_cost_per_year
    domain_costs_per_year + hosting_fee_per_year
  end

  def invoices
    Invoice.find_all_by_website_id(@id)
  end

end
