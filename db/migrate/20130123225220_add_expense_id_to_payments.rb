class AddExpenseIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :expense_id, :integer
  end
end
