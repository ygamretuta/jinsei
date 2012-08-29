class Catalog < ActiveRecord::Base
  belongs_to :business
  attr_accessible :description, :name
  has_many :products

  validates_presence_of :name
  validates_length_of :description, :in => 50..100, :allow_blank => true
  validates_length_of :name, :maximum => 255

  before_create :validate_unique_to_business

  extend FriendlyId
  friendly_id :name, use: :slugged

  def validate_unique_to_business
    if self.business.catalogs.find_by_name(self.name)
      errors.add('name', :taken)
      false
    end
  end
end
