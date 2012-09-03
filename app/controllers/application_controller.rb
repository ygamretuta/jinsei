class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to new_user_session_path
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin_user)
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from ActionController::UnknownAction, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from ActiveRecord::RecordInvalid, :with => :render_500
  end

  private
    def render_404(exception)
      @not_found_path = exception.message
      respond_to do |format|
        format.html {render template:"errors/error_404", layout:"layouts/application", status:404}
        format.all {render nothing:true, status:404}
      end
    end

    def render_500(exception)
      @error = exception
      respond_to do |format|
        format.html {render template:"errors/error_500", layout:"layouts/application", status:500}
        format.all {render nothing:true, status:500}
      end
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