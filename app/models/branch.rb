class Branch < ActiveRecord::Base
  attr_accessible :business_id, :location

  belongs_to :business

  validates_presence_of :location
end
