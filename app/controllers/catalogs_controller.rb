class CatalogsController < ApplicationController
  load_and_authorize_resource

  def index
    @business = Business.find(params[:business_id])
    @catalogs = @business.catalogs.all
    respond_with(@business, @catalogs)
  end

  def show
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.find(params[:id])
    @products = @catalog.products
    respond_with(@business, @catalog)
  end

  def new
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.build
    respond_with(@business, @catalog)
  end

  def edit
    @catalog = Catalog.find(params[:id])
  end

  def create
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.build(params[:catalog])
    flash[:notice] = "Catalog Successfully Created!" if @catalog.save
    respond_with(@business, @catalog)
  end

  def update
    @business = Business.find(params[:business_id])
    @catalog = Catalog.find(params[:id])
    flash[:notice] = "Catalog Updated!" if @catalog.update_attributes(params[:catalog])
    respond_with(@catalog)
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
  end
end
