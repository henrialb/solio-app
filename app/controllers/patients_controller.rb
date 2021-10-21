class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show]

  def index
    @patients = Patient.all
    render json: @patients
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    render json: @patient
  end

  def update
  end

  def destroy
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end
end
