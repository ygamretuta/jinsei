class Branch < ActiveRecord::Base
  attr_accessible :business_id, :location, :phone, :mobile

  belongs_to :business

  validates_presence_of :location
end
