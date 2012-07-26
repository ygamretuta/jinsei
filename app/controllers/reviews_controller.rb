class ReviewsController < ApplicationController

  layout proc {|controller| controller.request.xhr? ? false:'application'}
  before_filter :authenticate_user!, :except => [:index]
  before_filter :get_embedded_business, :only => [:pending_product]
  before_filter :require_owner, :only => [:pending_product]

  def index
    @business = Business.find(params[:business_id])

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])
    end

    @reviews = (@product.nil?) ? @business.reviews.approved: @product.reviews.approved

    if (@product.nil?)
      respond_with(@business, @reviews)
    else
      respond_with(@business, @product, @reviews)
    end
  end

  def new
    @business = Business.find(params[:business_id])

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])
      @review = @product.reviews.build
      @form_resources = [@business, @product, @review]
    else
      @review = @business.reviews.build
      @form_resources = [@business, @review]
    end

    respond_with(@review)
  end

  def create
    @business = Business.find(params[:business_id])

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])
      @review = @product.reviews.build(params[:review])
      @type = 'product'

      if @review.save
        flash[:notice] = 'Pending Review Submitted'
        redirect_to business_product_path(@business, @product)
      else
        @form_resources = [@business, @product, @review]
        respond_with(@business, @product, @review)
      end
    else
      @review = @business.reviews.build(params[:review])
      @type = 'business'

      if @review.save
        flash[:notice] = 'Pending Review Submitted'
        redirect_to business_path(@business)
      else
        @form_resources = [@business, @review]
        respond_with(@business, @review)
      end
    end
  end

  def edit
    @business = Business.find(params[:business_id])
    @review = Review.find(params[:id])

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])
      @form_resources = [@business, @product, @review]
      @type = 'product'
      respond_with(@business, @product, @review)
    else
      @form_resources = [@business, @review]
      @type = 'business'
      respond_with(@business, @product, @review)
    end
  end

  def update
    @business = Business.find(params[:business_id])
    @review = Review.find(params[:id])
    @review.update_attributes(params[:review])

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])
      redirect_to business_product_path(@business, @product)
    end

    redirect_to business_path(@business)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to request.referer
  end

  def pending_product
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
    respond_with(@business, @product, @reviews) do |format|
      format.html { render :template => 'reviews/pending' }
    end
  end
end