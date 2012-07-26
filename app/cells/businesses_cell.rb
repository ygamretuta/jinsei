class BusinessesCell < Cell::Rails

  helper ApplicationHelper

  def index(args)
    @businesses = args[:businesses]
    return render if @businesses.count > 0
    render :view => :blank_list
  end
end