class Reminders < ActiveRecord::Migration

  def self.up
    create_table :reminders do |table|
      table.column :invoice_id, :integer
      table.column :created_on, :date
      # will better track this via the invoice's paid_on field!
      #table.column :paid, :boolean
    end
  end

  def self.down
    drop_table :reminders
  end
  
end
