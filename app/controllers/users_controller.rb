class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #need to check if validation errors are being diisplayed in the form?
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      if !@user.admin
        redirect_to user_path(@user)
      else
        redirect_to admin_user(@user)
      end
    else
      render :new
    end
  end

  def admin_show
    return head(:forbidden) unless current_user.try(:admin)
    find_user
  end

  def show
    authorization
  end

  def edit
    authorization
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :admin)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def authorization #user is logged in and tries to access his own account, not someone else's account
    current_user && current_user == find_user ? @user = find_user : return head(:forbidden)
  end
end
