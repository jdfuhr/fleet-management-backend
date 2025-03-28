module Api
  module V1
    class UsersController < ApplicationController
      # before_action :authenticate_user!
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.all
        render json: @users, include: [:profile]
      end

      def show
        render json: @user, include: [:profile]
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :profile_id)
      end
    end
  end
end
