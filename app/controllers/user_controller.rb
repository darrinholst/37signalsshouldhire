class UserController < ApplicationController
  def show
    @user = User.find_by_username(params[:user])
    redirect_to root_url unless @user
  end
end
