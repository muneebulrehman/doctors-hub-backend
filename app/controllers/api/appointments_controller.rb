class Api::AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show]

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

  # Get the appointment for the given id
  def show
    render json: @appointment
  end

  # Create a new appointment
  def create
    params[:date] = params[:date]&.to_datetime

    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: { success: true, message: 'Appointment created successfully', appointment: @appointment },
             status: :created
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: appointment_error(:show) }, status: 404
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :date, :user_id)
  end
end
