class Business < ActiveRecord::Base
  validates_presence_of :name

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged
end
