class ClientIsActive < ActiveRecord::Migration
  def self.up
      add_column :clients, :is_active, :boolean
  end

  def self.down
      remove_column :clients, :is_active
  end
end
