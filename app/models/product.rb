class Product < ActiveRecord::Base
  belongs_to :business
  belongs_to :catalog
  attr_accessible :description, :name, :photo, :catalog_id, :remove_photo
  validates_presence_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :photo, PhotoUploader
end
