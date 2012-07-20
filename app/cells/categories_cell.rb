class CategoriesCell < Cell::Rails

  def index(args)
    @categories = args[:categories]
    @type = args[:type]
    return render if @categories.count > 0
    render :view => 'shared/blank_list'
  end
end