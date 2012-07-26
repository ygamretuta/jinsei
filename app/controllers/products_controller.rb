class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index, :show, :all, :category]
  layout proc {|controller| controller.request.xhr? ? false : "application"}
  load_and_authorize_resource

  before_filter :get_embedded_business
  before_filter :require_owner, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @business = Business.find_by_slug(params[:business_id])
    if params.has_key?(:catalog_id)
      @catalog = Catalog.find(params[:catalog_id])
      @products = @catalog.products.page params[:page]
      respond_with(@business, @catalog, @products)
    else
      @products = @business.products.page params[:page]
      respond_with(@business, @products)
    end
  end

  def show
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    @catalog = @product.catalog
    @features = @product.features
    respond_with(@product, :location => product_name_url(@business, @product))
  end

  def new
    @business = Business.find(params[:business_id])
    @categories = Category.all
    @catalogs = @business.catalogs.all
    @product = @business.products.build
    respond_with(@product)
  end

  def edit
    @business = Business.find(params[:business_id])
    @catalogs = @business.catalogs.all
    @categories = Category.all
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

  def category
    @type = 'product'
    @category = Category.find(params[:category_id])
    @categories = Category.all
    collection = @category.products.includes(:business).where('businesses.approved = ?', true).all
    @products = Kaminari.paginate_array(collection).page(params[:page])
  end

  def all
    @type = 'product'
    @categories = Category.all
    @type = 'product'
    collection = Product.includes(:business).where('businesses.approved = ?', true).all
    @products = Kaminari.paginate_array(collection).page(params[:page])
  end
end
