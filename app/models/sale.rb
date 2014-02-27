class Sale < ActiveRecord::Base
  belongs_to :item
  validates_length_of :purchaser_name, :maximum => 100
end
