class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #need to check if validation errors are being diisplayed in the form?
    @user = User.new(user_params)
    if @post.valid?
      @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :admin)
  end
end
