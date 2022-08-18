class HomeController < ApplicationController
  def index
    render json: { status: 200, message: 'Welcome to the API' }
  end
end
