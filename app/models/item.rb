class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :sales, :dependent => :destroy
  validates_length_of :description, :maximum => 100

  # Each item description must be unique for a given merchant
  validates_uniqueness_of :description, :scope => [:merchant_id]
end
