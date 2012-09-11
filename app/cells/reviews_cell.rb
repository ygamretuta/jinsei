class ReviewsCell < Cell::Rails

  include Devise::Controllers::Helpers
  helper_method :current_user, :user_signed_in?

  def index(args)
    @business = args[:business]
    @product = args[:product]
    @reviews = args[:reviews]
    return render if @reviews.respond_to?(:each) and @reviews.count > 0
    render :text => "<p class='alert'>#{t 'app.reviews_empty'}</p>"
  end
end