class Website < ActiveRecord::Migration
  def self.up
    create_table :websites do |table|
      table.column :name, :string
      table.column :client_id, :integer
      table.column :created_on, :date
      table.column :ftp_username, :string
      table.column :ftp_password, :string
    end
  end

  def self.down
    drop_table :websites
  end
end
