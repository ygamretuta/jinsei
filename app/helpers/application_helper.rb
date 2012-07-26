module ApplicationHelper
  def calculate_average_rating(reviews)
    if reviews and reviews.count > 0
      ratings = []
      reviews.each do |review|
        ratings << review.rating
      end
      return ratings.instance_eval {reduce(:+) / size.to_f}
    else
      return 0
    end
  end
end