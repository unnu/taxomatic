class DomainsWebsiteId < ActiveRecord::Migration
  def self.up
    add_column :domains, :website_id, :integer
  end

  def self.down
    remove_column :domains, :website_id
  end
end
