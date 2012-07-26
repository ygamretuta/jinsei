class Product < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :business
  belongs_to :catalog
  belongs_to :category

  has_many :reviews, :foreign_key => :reviewed_id
  has_many :features, :dependent => :destroy

  attr_accessible :description, :name, :photo, :catalog_id, :remove_photo, :in_stock, :category_id, :price
  validates_presence_of :name
  validates_presence_of :category

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

  def get_rating
    reviews = self.reviews.where(:approved=>true).where(:for=>'product')
    calculate_average_rating(reviews)
  end
end
