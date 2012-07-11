class Business < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy
  belongs_to :user

  extend FriendlyId
  friendly_id :name, use: :slugged

  def is_owned_by?(user)
    self.user == user
  end

  def profile
    @user = current_user
  end
end
