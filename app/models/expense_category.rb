class ExpenseCategory < ActiveRecord::Base

  validates_uniqueness_of :id
  has_many :expenses
    
end
