module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def update
        if find_user
          @user.update(user_params)
          render json: @user
        end
      end

      def delete
        find_user.delete
        redirect_to '/'
      end

      private

      def find_user
        @user = User.find_by(id: params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :phone_number, :admin)
      end
    end
  end
end
