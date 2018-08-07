class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #need to check if validation errors are being diisplayed in the form?
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @errors = @user.errors.messages
      render :new
    end
  end

  def show
    @user = current_user if authorization
    return head(:forbidden)
    redirect_to '/'
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
    current_user && current_user == find_user
  end
end
