class Business < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :category

  validate :rating_less_than_equal_5

  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :description, :photo, :remove_photo, :category_id, :rating, :address

  has_many :catalogs, :dependent => :destroy
  has_many :products, :dependent => :destroy
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

  private
    def rating_less_than_equal_5
      if self.rating > 5 or self.rating < 1
        errors.add(:rating, :invalid)
      end
    end
end