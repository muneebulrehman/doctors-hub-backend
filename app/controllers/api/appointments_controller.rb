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

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    params[:date] = params[:date]&.to_datetime

    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: appointment_error(:show) }, status: 404
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.permit(:doctor_id, :date, :user_id)
  end
end
