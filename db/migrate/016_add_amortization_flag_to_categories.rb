class AddAmortizationFlagToCategories < ActiveRecord::Migration
  def self.up
    add_column :expense_categories, :amortization, :boolean
    [3, 4, 5, 15, 16, 23].each do |category_id| 
      ExpenseCategory.find(category_id).update_attributes!(:amortization => true)
    end
  end

  def self.down
    remove_column :expense_categories, :amortization
  end
end
