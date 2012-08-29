class Business < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :category
  validates_length_of :description, :in => 50..100, :allow_blank => true
  validates_length_of :name, :maximum => 255

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo, :category_id, :address

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :reviews, :as => :reviewable

  belongs_to :user
  belongs_to :category

  extend FriendlyId
  friendly_id :name, use: :slugged

  def is_owned_by?(user)
    self.user == user
  end

  def is_reviewed_by?(user)
    return self.reviews.where(:user_id=>user.id).count > 0
  end

  def profile
    @user = current_user
  end
end