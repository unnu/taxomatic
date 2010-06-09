class MoreClientInfo < ActiveRecord::Migration
  def self.up
      add_column :clients, :email_address, :string
      add_column :clients, :phone, :string
      add_column :clients, :address, :string
  end

  def self.down
      remove_column :clients, :email_address
      remove_column :clients, :phone
      remove_column :clients, :address
  end
end
