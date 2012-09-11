class Review < ActiveRecord::Base
  attr_accessible :approved, :user_id, :text, :rating, :title, :reported
  belongs_to :reviewable, :polymorphic => true
  belongs_to :user

  validates_presence_of :rating
  validates_presence_of :title
  validates_presence_of :text
  validates_numericality_of :rating
  validates_numericality_of :user_id
  validates_presence_of :user_id
  validates_length_of :text, :in=> 50..300

  validate :rating_less_than_equal_5

  scope :approved, where(:approved => true)
  scope :reported, where(:reported => true)

  private
    def rating_less_than_equal_5
      if self.rating and (self.rating > 5 or self.rating < 1)
        errors.add(:rating, :invalid)
      end
    end
end