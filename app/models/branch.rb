class Branch < ActiveRecord::Base
  attr_accessible :business_id, :location, :phone, :mobile

  belongs_to :business

  validates_presence_of :location
  validates_length_of :location, :maximum=>255
end
