class ProductsController < ApplicationController
  layout proc {|controller| controller.request.xhr? ? false : "application"}

  def index
    @business = Business.find_by_slug(params[:business_id])
    if params.has_key?(:catalog_id)
      @catalog = Catalog.find(params[:catalog_id])
      @products = @catalog.products.all
      respond_with(@business, @catalog, @products)
    else
      @products = @business.products.all
      respond_with(@business, @products)
    end
  end

  def show
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    respond_with(@product, :location => product_name_url(@business, @product))
  end

  def new
    @business = Business.find(params[:business_id])
    @product = @business.products.build
    respond_with(@product)
  end

  def edit
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
  end

  def create
    @business = Business.find(params[:business_id])
    @product = @business.products.build(params[:product])
    @product.save
    respond_with(@business, @product)
  end

  def update
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    flash[:notice] = 'Product Successfully Updated' if @product.update_attributes(params[:product])
    respond_with(@business, @product)
  end

  def destroy
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to business_products_path(@business)
  end
end
