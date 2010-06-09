class WebsiteHostingFee < ActiveRecord::Migration
  def self.up
    add_column :websites, :hosting_fee, :integer    
  end

  def self.down
    remove_column :websites, :hosting_fee
  end
end
