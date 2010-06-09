class PaymentTaxDeclarationId < ActiveRecord::Migration
  def self.up
    # old name
    remove_column :payments, :in_tax_declaration
    add_column :payments, :tax_declaration_id, :integer
  end

  def self.down
    add_column :payments, :tax_declaration_id
  end
end
