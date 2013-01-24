require 'harvested'

module Harvest

  class InvoiceImport
    
    def self.run!(password)
      new(password).run!
    end
    
    def initialize(password)
      c = AppConfig['harvest']
      @client = Harvest.client(c['subdomain'], c['username'], c['password'])
    end

    def run!
      @client.invoices.all.each do |harvest_invoice|
        harvest_invoice = Harvest::InvoiceWrapper.new(harvest_invoice)
        if harvest_invoice.paid? 
          invoice = ::Invoice.find_by_ref_nr(harvest_invoice.ref_nr)
          if invoice
            puts "Harvest invoice #{harvest_invoice.ref_nr} is already in the system."
          else
            puts "Importing invoice #{harvest_invoice.ref_nr} from Harvest."
            invoice = ::Invoice.create_from_harvest!(harvest_invoice)
          end
        end
      end
    end
  end
end