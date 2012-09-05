class BusinessesController < ApplicationController

  before_filter :authenticate_user!, :except=>[:show,:index, :category]
  before_filter :get_business, :only => [:show, :edit, :update, :destroy]
  before_filter :require_owner, :only => [:edit, :update, :destroy]
  before_filter :greater_than_24, :only => [:new]

  def get_business
    @business = Business.find(params[:id])
  end

  def index
    @categories = Category.all
    @businesses = Business.where(:approved=>true).page(params[:page])
    @type = 'business'
    respond_with(@businesses)
  end

  def new
    respond_with(@business=Business.new)
  end

  def create
    @user = current_user
    @business = @user.businesses.create(params[:business])
    if @business.save
      flash[:notice] = t("flash.actions.create.notice", {:resource_name => "Business"})
      redirect_to user_businesses_path
    else
      respond_with(@business)
    end
  end

  def show
    if @business.approved?
      @categories = Category.all
      @products = @business.products.page params[:page]
      @catalogs = @business.catalogs.limit(4)
      respond_with(@business)
    else
      render :text=>'Not Found', :status => 404
    end
  end

  def edit
    respond_with(@business)
  end

  def update
    if @business.update_attributes(params[:business])
      flash[:notice] = t("flash.actions.update.notice", {:resource_name => "Business"})
      redirect_to user_businesses_path
    else
      respond_with(@business)
    end
  end

  def destroy
    @business = Business.find(params[:id])

    if @business
      @business.destroy
    end

    redirect_to root_path
  end

  def category
    @type = 'business'
    @categories = Category.all
    @category = Category.find(params[:category_id])
    @businesses = @category.businesses.page params[:page]
  end

  private
    def greater_than_24
      if ! current_user.last_business_registered.blank? and current_user.last_business_registered > 24.hours.ago
        flash[:notice] = t "app.less_than_24"
        redirect_to user_businesses_path
      end
    end
end