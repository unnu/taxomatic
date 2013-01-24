class TaxCalculator
  class << self
    
    def net_from_gross(gross, tax_rate)
      return gross if tax_rate == 0
      ((100 * gross).to_f / (100 + tax_rate)).round
    end
    
    def gross_from_net(net, tax_rate)
      return net if tax_rate == 0
      # calculate the tax amount separately and round that. 
      tax = ((net * tax_rate) / 100.to_f).round
      # then add up the integers.
      net + tax
    end
    
  end
end
