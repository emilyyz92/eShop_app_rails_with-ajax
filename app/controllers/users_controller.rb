class UsersController < ApplicationController

  def home
  end

  def new
    @user = User.new
    @errors = nil
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
    if authorization
      @user = current_user
    else
      flash[:error] = "Access Denied."
      redirect_to '/'
    end
  end

  def edit
    authorization
  end

  def update
    if authorization
      find_user
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:error] = "Access Denied."
      redirect_to '/'
    end
  end

  def destroy
    if authorization
      find_user.delete
      flash[:message] = "Account Deleted"
      redirect_to '/'
    else
      flash[:error] = "Authentication failed."
    end
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
