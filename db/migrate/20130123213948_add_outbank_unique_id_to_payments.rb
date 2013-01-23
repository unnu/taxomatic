class AddOutbankUniqueIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :outbank_unique_id, :string
  end
end
