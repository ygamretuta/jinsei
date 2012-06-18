class Catalog < ActiveRecord::Base
  belongs_to :business
  attr_accessible :description, :name
  has_many :products

  extend FriendlyId
  friendly_id :name, use: :slugged
end
