class Business < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :category

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo, :category_id, :rating, :address

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :reviews, :foreign_key => :reviewed_id

  belongs_to :user
  belongs_to :category

  extend FriendlyId
  friendly_id :name, use: :slugged

  def is_owned_by?(user)
    self.user == user
  end

  def profile
    @user = current_user
  end
end