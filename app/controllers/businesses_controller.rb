class BusinessesController < ApplicationController

  before_filter :authenticate_user!, :except=>[:show,:index]
  before_filter :get_business, :only => [:show, :edit, :update, :destroy]
  before_filter :require_owner, :only => [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @businesses = Business.where(:approved=>true).page(params[:page]).per(1)
    respond_with(@businesses)
  end

  def new
    respond_with(@business=Business.new)
  end

  def create
    @user = current_user
    @business = @user.businesses.create(params[:business])
    flash[:notice] = t("flash.actions.create.notice", {:resource_name => "Business"}) if @business.save
    redirect_to user_businesses_path
  end

  def show
    if @business.approved?
      @categories = Category.all
      @products = @business.products.page params[:page]
      @catalogs = @business.catalogs.all
      respond_with(@business)
    else
      render :text=>'Not Found', :status => 404
    end
  end

  def edit
    respond_with(@business)
  end

  def update
    flash[:notice] = t("flash.actions.update.notice", {:resource_name => "Business"}) if @business.update_attributes(params[:business])
    redirect_to user_businesses_path
  end

  def destroy
    @business = Business.find(params[:id])

    if @business
      @business.destroy
    end

    redirect_to root_path
  end

  protected
    def get_business
      @business = Business.find(params[:id])
    end
end