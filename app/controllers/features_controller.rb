class FeaturesController < ApplicationController
  layout proc {|controller| controller.request.xhr? ? false : "application"}

  before_filter :authenticate_user!, :except => [:index]
  before_filter :setup, :except => [:index]
  before_filter :require_owner, :except => [:index]

  def setup
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:product_id])
  end

  def index
    setup
    @features = @product.reviews
  end

  # differs in that this does not render the sidebar and the headers for the review
  def all
    render :action => :index, :template => 'features/all'
  end

  def destroy
    setup
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to business_product_path(@business, @product)
  end

  def new
    setup
    @feature = @product.features.build
    respond_with(@business, @product, @feature)
  end

  def create
    setup
    @feature = @product.features.build(params[:feature])

    if @feature.save
      flash[:notice] = 'New feature successfully added!'
      redirect_to business_product_path(@business, @product)
    else
      respond_with(@business, @product, @feature)
    end
  end

  def edit
    setup
    @feature = Feature.find(params[:id])
    respond_with(@feature)
  end

  def update
    setup
    @feature = Feature.find(params[:id])
    @feature.update_attributes(params[:feature])

    respond_with(@business, @product, @feature) do |format|
      format.html { render }
      format.json { respond_with_bip(@feature)}
    end
  end
end
