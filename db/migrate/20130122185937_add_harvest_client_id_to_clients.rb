class AddHarvestClientIdToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :harvest_client_id, :integer
  end

  def self.down
    remove_column :clients, :harvest_client_id
  end
end
