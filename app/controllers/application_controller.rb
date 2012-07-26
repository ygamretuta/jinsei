class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :js, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to new_user_session_path
  end

  private
    def record_not_found
      render :text => "404 Not Found Baby!", :status => 404
    end

  protected
    def require_owner
      object = instance_variable_get("@business")
      unless current_user && object.is_owned_by?(current_user)
        respond_to do |format|
          format.html{render :text => 'Not Allowed', :status=>:forbidden}
        end
      end
    end

    def get_embedded_business
      if params.has_key?('business_id')
        @business = Business.find(params[:business_id])
      end
    end
end