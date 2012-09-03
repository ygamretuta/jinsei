class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    begin
      @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
    rescue ActiveRecord::RecordInvalid
      flash[:notice] = t "app.oauth_error_message"
      redirect_to login_path
    end

    if @user.persisted?
      flash[:notice] = t 'devise.omniauth_callbacks.success', :kind => 'Facebook'
      sign_in_and_redirect @user, :event=>:authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end