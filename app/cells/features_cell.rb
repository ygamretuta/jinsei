class FeaturesCell < Cell::Rails

  include Devise::Controllers::Helpers
  helper_method :current_user

  def index(args)
    @business = args[:business]
    @product = args[:product]
    @features = @product.features
    return render if @features and @features.count > 0
    render :view => :blank_list
  end
end