class ReviewsCell < Cell::Rails

  def index(args)
    @business = args[:business]
    @product = args[:product]
    @reviews = args[:reviews]
    return render if @reviews.respond_to?(:each) and @reviews.count > 0
    render :text, '<p class="alert">No Reviews Yet</p>'
  end
end