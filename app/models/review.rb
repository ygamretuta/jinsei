class Review < ActiveRecord::Base
  attr_accessible :approved, :reviewed_id, :type, :user_id, :text, :rating, :title

  belongs_to :business
  belongs_to :product

  validates_presence_of :rating
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :type

  validates_numericality_of :rating

  validate :rating_less_than_equal_5
  validate :type_must_be_product_or_business

  scope :approved, where(:approved => true)

  private
    def rating_less_than_equal_5
      if self.rating and (self.rating > 5 or self.rating < 1)
        errors.add(:rating, :invalid)
      end
    end

    def type_must_be_product_or_business
     if not self.type == 'product' or self.type == 'business'
       errors.add(:type, :invalid)
     end
    end
end