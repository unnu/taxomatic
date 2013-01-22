class InvoiceNumber < ActiveRecord::Base

  def self.read
    InvoiceNumber.first.last_invoice_number
  end

end
