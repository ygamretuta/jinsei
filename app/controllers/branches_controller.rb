class BranchesController < ApplicationController

  layout proc {|controller| controller.request.xhr? ? false : "application"}

  before_filter :setup

  def setup
    @business = Business.find(params[:business_id])
  end

  def index
    @branches = @business.branches
  end

  def all
    @branches = @business.branches
  end

  def new
    respond_with(@branch = @business.branches.build)
  end

  def create
    @branch = @business.branches.build(params[:branch])

    if @branch.save
      flash[:notice] = 'Branch Successfully Created!'
      redirect_to business_path(@business)
    else
      respond_with(@branch)
    end
  end

  def edit
    respond_with(@branch = @business.branch.find(params[:id]))
  end

  def update
    @branch = @business.branch.find(params[:id])

    if @branch.update_attributes(params[:branch])
      flash[:notice] = 'Branch Successfully Updated!'
      redirect_to business_path(@business)
    else
      respond_with(@branch)
    end
  end

  def destroy
    @branch = @business.branch.find(params[:id])
    @branch.destroy
    flash[:notice] = 'Branch details successfully deleted!'
    redirect_to business_path(@business)
  end
end