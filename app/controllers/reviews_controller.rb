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

    # TODO: Improve this code
    if @product.blank?
      @reviews = @business.reviews.page(params[:page]).per(2)
      @type = 'business'
    else
      @reviews = @product.reviews.page(params[:page]).per(2)
      @type = 'product'
    end
    # ENDTODO

    if @product.blank?
      respond_with(@business, @reviews)
    else
      respond_with(@business, @product, @reviews)
    end
  end


  def new
    @business = Business.find(params[:business_id])

    if @business.is_owned_by?(current_user)
      if params.has_key?('product_id')
        flash[:notice] = t "app.owned_cannot_review_product"
      else
        flash[:notice] = t "app.owned_cannot_review_business"
      end
      redirect_to :back
      return
    end

    if params.has_key?('product_id')
      @product = Product.find(params[:product_id])

      if @product.is_reviewed_by?(current_user)
        flash[:notice] = t "app.reviewed_product"
        redirect_to business_product_path(@business, @product)
        return
      end

      @review = @product.reviews.build
      @form_resources = [@business, @product, @review]
      @type = 'product'
    else
      if @business.is_reviewed_by?(current_user)
        flash[:notice] = t "app.reviewed_business"
        redirect_to business_path(@business)
        return
      end

      @review = @business.reviews.build
      @form_resources = [@business, @review]
      @type = 'business'
    end

    respond_with(@review)
  end

def create
  @business = Business.find(params[:business_id])

  if @business.is_owned_by?(current_user)
    flash[:notice] = t "app.owned_cannot_review"
    redirect_to :back
  end

  if params.has_key?('product_id')
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(params[:review])
    @review.user_id = current_user.id

    if @review.save
      flash[:notice] = 'Pending Review Submitted'
      redirect_to business_product_path(@business, @product)
    else
      @form_resources = [@business, @product, @review]
      respond_with(@business, @product, @review)
    end
  else
    @review = @business.reviews.build(params[:review])
    @review.user_id = current_user.id

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

  def report
    @review = Review.find(params[:id])
    @review.reported=true
    @review.save
    flash[:notice] = t "app.report_review"
    redirect_to request.referer
  end
end