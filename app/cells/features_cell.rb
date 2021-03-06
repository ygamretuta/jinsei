class FeaturesCell < Cell::Rails

  include Devise::Controllers::Helpers
  helper_method :current_user, :user_signed_in?

  def index(args)
    @business = args[:business]
    @product = args[:product]
    @features = @product.features
    return render if @features and @features.count > 0
    render :text => "<p class='alert'>#{t "app.features_empty"}</p>"
  end
end