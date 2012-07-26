class CategoriesCell < Cell::Rails

  def index(args)
    @categories = args[:categories]
    @type = args[:type]
    return render if @categories.count > 0
    render :text => '<p class="alert">No Categories Yet</p>'
  end
end