class UpdateCanceledOnPayments < ActiveRecord::Migration
  def self.up
    change_column :payments, :canceled, :integer, :limit => 1, :default => false, :null => false
  end

  def self.down
  end
end
