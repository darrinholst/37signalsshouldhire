class UserController < ApplicationController
  def show
    @user = User.find_by_username(params[:user])
    render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => false unless @user
  end
end
