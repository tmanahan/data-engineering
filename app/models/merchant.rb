class Merchant < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  validates_length_of :name, :maximum => 100
  validates_length_of :address, :maximum => 100

  # each merchant must have a unique name
  validates_uniqueness_of :name
end
