class BranchesCell < Cell::Rails

  def index(args)
    @business = args[:business]
    @branches = args[:branches]
    @editable ||= args[:editable]
    return render if @branches.respond_to?(:each) and @branches.count > 0
    render :text => "<p class='alert'>#{t 'app.branches_empty'}</p>"
  end
end