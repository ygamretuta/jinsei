class CatalogsController < ApplicationController
  load_and_authorize_resource

  def index
    @business = Business.find(params[:business_id])
    @catalogs = @business.catalogs.page params[:page]
    respond_with(@business, @catalogs)
  end

  def show
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.find(params[:id])
    @products = @catalog.products.page params[:page]
    respond_with(@business, @catalog)
  end

  def new
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.build
    respond_with(@business, @catalog)
  end

  def edit
    @business = Business.find(params[:business_id])
    @catalog = Catalog.find(params[:id])
  end

  def create
    @business = Business.find(params[:business_id])
    @catalog = @business.catalogs.build(params[:catalog])

    if @catalog.save
      flash[:notice] = "Catalog Successfully Created!"
      redirect_to business_catalogs_path(@business)
    else
      respond_with(@business, @catalog)
    end
  end

  def update
    @business = Business.find(params[:business_id])
    @catalog = Catalog.find(params[:id])

    if @catalog.update_attributes(params[:catalog])
      flash[:notice] = "Catalog Updated!"
      redirect_to business_catalog_path(@business, @catalog)
    else
      respond_with(@business, @catalog)
    end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
  end
end
