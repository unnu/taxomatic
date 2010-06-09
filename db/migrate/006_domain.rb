class Domain < ActiveRecord::Migration
  def self.up
    create_table :domains do |table|
      table.column :name, :string
      table.column :website_id, :integer
      table.column :created_on, :date
    end
  end

  def self.down
    drop_table :domains
  end
end
