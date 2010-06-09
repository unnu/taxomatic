class Reminder < ActiveRecord::Base
  # i have the foreign key
  belongs_to :invoice
end
