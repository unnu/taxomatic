class ExpenseCategory < ActiveRecord::Base

  validates_uniqueness_of :id
  has_many :expenses

  scope :private, lambda { where(:private => true) }
  scope :tax_relevant, lambda { where(:private => false) }

end
