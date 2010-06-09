class PaymentInTaxDeclaration < ActiveRecord::Migration
  def self.up
    add_column :payments, :in_tax_declaration, :integer
  end

  def self.down
    remove_column :payments, :in_tax_declaration
  end
end
