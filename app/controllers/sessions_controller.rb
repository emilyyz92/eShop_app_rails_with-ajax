class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Authentication Failed"
      render 'new'
    end
  end

  def create_google #for logging in through OmniAuth google
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
    end

    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def delete
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
