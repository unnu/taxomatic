class TaxDeclaration < Payment
  has_many :invoices
  has_many :expenses
end
