class BusinessesCell < Cell::Rails

  def index(args)
    @businesses = args[:businesses]
    return render if @businesses.count > 0
    render :view => :blank_list
  end
end