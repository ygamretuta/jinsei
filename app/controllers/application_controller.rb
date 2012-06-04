class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private
    def record_not_found
      render :text => "404 Not Found Baby!", :status => 404
    end
end
