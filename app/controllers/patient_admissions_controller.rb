class PatientAdmissionsController < ApplicationController
  before_action :set_patient_admission, only: %i[show update destroy]

  def index
    @patient_admissions = PatientAdmission.all
    render json: PatientAdmissionBlueprint.render(@patient_admissions)
  end

  def create
    @patient_admission = PatientAdmission.new(patient_admission_params)
    if @patient_admission.save
      render json: PatientAdmissionBlueprint.render(@patient_admission)
      PatientFile.create(patient_file_params)
    else
      render json: @patient_admission.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientAdmissionBlueprint.render(@patient_admission)
  end

  def update
    if @patient_admission.update(patient_admission_params)
      render json: PatientAdmissionBlueprint.render(@patient_admission)
    else
      render json: @patient_admission.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_admission.destroy
  end

  private

  def set_patient_admission
    @patient_admission = PatientAdmission.find(params[:id])
  end

  def patient_admission_params
    params.require(:patient_admission).permit(:date, :patient_id)
  end

  def patient_file_params
    {
      patient_admission_id: @patient_admission.id,
      open_date: @patient_admission.date
    }
  end
end
