require 'swagger_helper'

RSpec.describe 'APPOINTMENTS API', type: :request do
  first_user = User.all[0]
  doctor = Doctor.all[0]

  path '/api/appointments' do
    get 'Retrieves all appointments of the user' do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: 'Params', in: :url, type: :integer
      response '200', 'List of appointments' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   doctor_id: { type: :integer },
                   date: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   doctor: { type: :object }
                 }
               }
        run_test!
      end
    end
  end

  path '/api/appointments/{id}' do
    get 'Retrieves the appointment' do
      tags 'Appointments', 'Appointment'
      parameter name: :id, in: :path, type: :string
      response '200', 'appointment found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :date },
                 created_at: { type: :date },
                 updated_at: { type: :date }
               }
        let(:id) do
          Appointment.create(
            user_id: first_user.id,
            doctor_id: doctor.id,
            date: '2020-01-01'
          ).id
        end
        run_test!
      end
    end
  end

  path '/api/appointments' do
    post 'Creates an appointment' do
      tags 'Appointments', 'Appointment'
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          date: { type: :date },
          user_id: { type: :integer }
        },
        required: %w[doctor_id date user_id]
      }

      response '201', 'appointment created' do
        doctor = Doctor.all[0]
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now, user_id: first_user&.id } }
        run_test! do |res|
          expect(JSON.parse(res.body).keys).to eq(%w[success message appointment])
        end
      end
    end
  end
end
