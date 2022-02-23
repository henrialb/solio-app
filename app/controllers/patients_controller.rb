class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.active.includes(:patient_files)
    render json: PatientBlueprint.render(@patients)
  end

  def all
    @patients = Patient.all
    render json: PatientBlueprint.render(@patients)
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: PatientBlueprint.render(@patient)
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientBlueprint.render(@patient)
  end

  def update
    if @patient.update(patient_params)
      render json: PatientBlueprint.render(@patient)
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :name, :dob, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex, :monthly_fee, :balance)
  end
end
