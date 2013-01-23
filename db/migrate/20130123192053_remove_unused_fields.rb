class RemoveUnusedFields < ActiveRecord::Migration
  def up
    drop_table :websites
    drop_table :reminders
    drop_table :invoice_numbers
    drop_table :domains
    # payments
    remove_column :payments, :website_id
    remove_column :payments, :interval
    # clients
    remove_column :clients, :person
    remove_column :clients, :email_address
    remove_column :clients, :phone
    remove_column :clients, :address
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
