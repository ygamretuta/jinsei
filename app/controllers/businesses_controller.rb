class BusinessesController < ApplicationController

  def index
    respond_with(@businesses=Business.all)
  end

  def new
    respond_with(@business=Business.new)
  end

  def create
    @business = Business.new(params[:business])
    flash[:notice] = t("flash.actions.create.notice", {:resource_name => "Business"}) if @business.save
    respond_with(@business, :location => business_name_url(@business))
  end

  def show
    @business = Business.find(params[:id])
    @products = @business.products.all
    @catalogs = @business.catalogs.all
    respond_with(@business)
  end

  def edit
    @business = Business.find(params[:id])
    respond_with(@business)
  end

  def update
    @business = Business.find(params[:id])
    flash[:notice] = t("flash.actions.update.notice", {:resource_name => "Business"}) if @business.update_attributes(params[:business])
    respond_with(@business)
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to root_path
  end
end
