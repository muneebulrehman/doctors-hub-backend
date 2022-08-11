class Api::UsersController < ApplicationController
  def create
    if User.exists?(username: params[:username])
      render json: { error: 'Username already exists' }, status: :unprocessable_entity
    else
      @user = User.create(user_params)
      render json: { success: true, message: "User created successfully", user: @user }, status: :created
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user.present?
      render json: { success: true, message: "Logged in successfully", user: @user }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
