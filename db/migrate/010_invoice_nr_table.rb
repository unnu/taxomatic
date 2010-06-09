class InvoiceNrTable < ActiveRecord::Migration
  def self.up
    create_table :invoice_number do |t|
      t.column :last_invoice_number, :integer
    end
  end

  def self.down
    drop_table :invoice_number
  end
end
