class CreateInvoiceNumbers < ActiveRecord::Migration
  def self.up
    create_table :invoice_numbers do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :invoice_numbers
  end
end
