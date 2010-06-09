class InvoiceNumber < ActiveRecord::Base

  def self.read
    InvoiceNumber.find(:first).last_invoice_number
  end

end
