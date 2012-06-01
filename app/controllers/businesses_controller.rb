class BusinessesController < ApplicationController

  def index
    respond_with(@businesses=Business.all)
  end

  def new
    respond_with(@business=Business.new)
  end

  def create
    @business = Business.new(params[:business])
    @business.save
    respond_with(@business, :location => business_name_url(@business))
  end

  def show
    if params.include?(:name)
      name = params[:name].to_s.titleize
      @business = Business.find_by_name(name)
    else
      @business = Business.find(params[:id])
    end
    respond_with(@business)
  end

  def edit
    @business = Business.find(params[:id])
    respond_with(@business)
  end

  def update
    @business = Business.find(params[:id])
    @business.update_attributes(params[:business])
    respond_with(@business)
  end

  def destroy

  end
end
