class Category < ActiveRecord::Base
  has_many :products
  has_many :businesses

  attr_accessible :name, :description, :slug
  validates_presence_of :name
  validates_uniqueness_of :slug
  validates_length_of :description, :in=> 50..100, :allow_blank => true

  extend FriendlyId
  friendly_id :name, use: :slugged
end