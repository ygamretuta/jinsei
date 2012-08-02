class BusinessesCell < Cell::Rails

  helper ApplicationHelper

  def index(args)
    @businesses = args[:businesses]
    return render if @businesses.count > 0
    render :text => "<p class='alert'>#{t 'app.businesses_empty'}</p>"
  end
end