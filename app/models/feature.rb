class Feature < ActiveRecord::Base
  attr_accessible :feature, :product_id

  belongs_to :product

  validates_presence_of :feature
  validates_presence_of :product
  validates_associated :product
  validates_length_of :feature, :in => 50..100
end