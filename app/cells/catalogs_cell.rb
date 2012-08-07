class CatalogsCell < Cell::Rails

  helper ApplicationHelper

  def index(args)
    @business = args[:business]
    @catalogs = args[:catalogs]
    return render if @catalogs.respond_to?(:each) and @catalogs.count > 0
    render :text => "<p class='alert'>#{t 'app.catalogs_empty'}"
  end
end