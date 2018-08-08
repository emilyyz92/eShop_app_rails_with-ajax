class ApplicationController < ActionController::Base
  helper_method :current_user, :admin_user



  def current_user
    if session[:user_id]
      User.find_by(id: session[:user_id])
    end
  end

  def admin_user
    User.find_by(id: session[:user_id]).admin
  end
end
