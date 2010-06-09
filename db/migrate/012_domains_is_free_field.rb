class DomainsIsFreeField < ActiveRecord::Migration
  def self.up
      add_column :domains, :is_free, :boolean
  end

  def self.down
      remove_column :domains, :is_free
  end
end
