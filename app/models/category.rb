class Category < ActiveRecord::Base
  has_many :products

  attr_accessible :name, :description, :slug
  validates_presence_of :name
  validates_uniqueness_of :slug

  extend FriendlyId
  friendly_id :name, use: :slugged
end