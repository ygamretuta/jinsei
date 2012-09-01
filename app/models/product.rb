class Product < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :business
  belongs_to :catalog
  belongs_to :category

  has_many :reviews, :as => :reviewable
  has_many :features, :dependent => :destroy

  attr_accessible :description, :name, :photo, :catalog_id, :remove_photo, :in_stock, :category_id, :price,
      :call_for_pricing

  validates_presence_of :name
  validates_presence_of :category
  validates_length_of :description, :in => 50..600, :allow_blank => true
  validates_length_of :name, :maximum => 255

  before_create :unique_to_business

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :photo, PhotoUploader

  def unique_to_business
    if self.business.products.find_by_name(self.name)
      errors.add('name', :taken)
      false
    end
  end

  def is_reviewed_by(user)
    return self.reviews.where(:user_id=>user.id).count > 0
  end

  def get_rating
    reviews = self.reviews.where(:approved=>true)
    calculate_average_rating(reviews)
  end
end