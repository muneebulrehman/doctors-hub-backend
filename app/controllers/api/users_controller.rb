class Api::UsersController < ApplicationController
  def create
    if User.exists?(username: params[:username])
      return render json: { success: false, error: 'Username already exists' }
    end

    @user = User.new(user_params)
    if @user.save
      render json: { success: true, message: 'User created successfully', user: @user }, status: :created
    else
      render json: { success: false, error: 'User not created', message: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user.present?
      render json: { success: true, message: 'Logged in successfully', user: @user }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
