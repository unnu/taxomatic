module Harvest
  class InvoiceWrapper
    
    include MoneyStringParser
    
    def initialize(api_object)
      @api_object = api_object
    end
    
    def amount_net
      (amount_gross - amount_tax)
    end
    
    def amount_gross
      to_cents(@api_object.amount)
    end
    
    def amount_tax
      to_cents(@api_object.tax_amount)
    end
    
    def tax_rate
      tax_rate = @api_object.tax.split('.').first.to_i
      raise StandardError, "Unexpected tax rate #{@api_object.tax} received from Harvest" if tax_rate != 19
      tax_rate
    end
   
    def client_id
      @api_object.client_id.to_i
    end
    
    def paid?
      @api_object.state == "paid"
    end
    
    def ref_nr
      @api_object.number
    end
    
    private 
      
      def method_missing(args)
        @api_object.send(args)
      end
  end
  
end