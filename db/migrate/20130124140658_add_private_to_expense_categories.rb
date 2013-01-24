class AddPrivateToExpenseCategories < ActiveRecord::Migration
  def change
    add_column :expense_categories, :private, :boolean, :default => false
  end
end
