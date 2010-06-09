class PaymentsAddWebsiteId < ActiveRecord::Migration
  def self.up
    add_column :payments, :website_id, :integer
  end

  def self.down
    add_column :payments, :website_id
  end
end
