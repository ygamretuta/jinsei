class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @user = current_user
    respond_with(@user)
  end
end