class BusinessesController < ApplicationController

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
    if params.include?(:name)
      name = params[:name].to_s.titleize
      @business = Business.find_by_name!(name)
    elsif params[:id].to_i == 0
      name = params[:id].to_s.titleize
      @business = Business.find_by_name!(name)
    else
      @business = Business.find(params[:id])
    end

    respond_with(@business)
  end

  def edit
    if params[:id].to_i == 0
      name = params[:id].to_s.titleize
      @business = Business.find_by_name!(name)
    else
      @business = Business.find(params[:id])
    end
    respond_with(@business)
  end

  def update
    if params[:id].to_i == 0
      name = params[:id].to_s.titleize
      @business = Business.find_by_name!(name)
    else
      @business = Business.find(params[:id])
    end
    flash[:notice] = t("flash.actions.update.notice", {:resource_name => "Business"}) if @business.update_attributes(params[:business])
    respond_with(@business)
  end

  def destroy
    if params[:id].to_i == 0
      name = params[:id].to_s.titleize
      @business = Business.find_by_name!(name)
    else
      @business = Business.find(params[:id])
    end

    @business.destroy
    redirect_to root_path
  end
end
