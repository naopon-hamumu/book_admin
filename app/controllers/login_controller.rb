class LoginController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.where(name: params[:name], password: params[:password].find)
    raise LoginFailed unless @user
  end
end
