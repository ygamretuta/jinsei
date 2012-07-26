class Branch < ActiveRecord::Base
  attr_accessible :business_id, :location

  belongs_to :business
end
