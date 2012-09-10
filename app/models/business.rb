class Business < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :category
  validates_length_of :description, :in => 50..600, :allow_blank => true
  validates_length_of :name, :maximum => 255
  validate :register_every_24_hours

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo, :category_id, :address, :approved

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :reviews, :as => :reviewable, :dependent => :destroy

  belongs_to :user
  belongs_to :category

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :assign_user_last_registered

  def is_owned_by?(user)
    self.user == user
  end

  def is_reviewed_by?(user)
    return self.reviews.where(:user_id=>user.id).count > 0
  end

  def profile
    @user = current_user
  end

  def register_every_24_hours
    if ! self.user.last_business_registered.blank? and self.user.last_business_registered < 24.hours.ago
      errors.add(:name, :less_than_24)
    end
  end

  def assign_user_last_registered
    self.user.last_business_registered = Time.now
    self.user.save
  end
end