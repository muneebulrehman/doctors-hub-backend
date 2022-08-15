class AppointmentsController < ApplicationController
    before_action :set_appointment, only: %i[show update destroy]
  
    rescue_from Date::Error, with: :invalid_date
  
    # GET /appointments
    def index
      @current_user = User.where({ user_id: params[:user_id] })
      if @current_user
        @appointments = Appointment.where({ user_id: params[:user_id] }).includes(:doctor).to_json(include: :doctor)
  
        render json: @appointments, status: :ok
      else
        render json: { error: appointment_error(:index) }, status: 422
      end
    end
  end