class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #need to check if validation errors are being diisplayed in the form?
    @user = User.new(user_params)
    if @post.valid?
      @user.save
      session[:user_id] = @user.id
      if !@user.admin
        redirect_to user_path(@user)
      else
        redirect_to admin_user
    else
      render :new
    end
  end

  def admin_show
    return head(:forbidden) unless current_user.try(:admin)
    find_user
  end

  def show
    current_user ? find_user : redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :admin)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
