class ProductsCell < Cell::Rails

  helper ApplicationHelper

  def index(args)
    @type = args[:type]
    @products = args[:products]
    @business = args[:business]
    @catalog = args[:catalog]
    return render if @products.count and @products.count > 0
    render :view => :blank_list
  end
end