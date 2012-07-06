class BusinessesController < ApplicationController

  before_filter :authenticate_user!, :except=>[:show,:index]
  before_filter :get_business, :only => [:show, :edit, :update, :destroy]
  before_filter :require_owner, :only => [:edit, :update, :destroy]
  load_and_authorize_resource

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
    @products = @business.products.all
    @catalogs = @business.catalogs.all
    respond_with(@business)
  end

  def edit
    respond_with(@business)
  end

  def update
    flash[:notice] = t("flash.actions.update.notice", {:resource_name => "Business"}) if @business.update_attributes(params[:business])
    respond_with(@business)
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to root_path
  end

  protected
    def get_business
      @business = Business.find(params[:id])
    end
end
