class ProductsCell < Cell::Rails

  def index(args)
    @products = args[:products]
    @business = args[:business]
    @catalog = args[:catalog]
    render
  end
end
