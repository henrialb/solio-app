class PatientAdmissionsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patient_admissions = PatientAdmission.all
    render json: PatientAdmissionsBlueprint.render(@patient_admissions)
  end

  def create
    @patient_admission = PatientAdmission.new(patient_admission_params)
    if @patient_admission.save
      render json: PatientAdmissionsBlueprint.render(@patient_admission)
    else
      render json: @patient_admission.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientAdmissionsBlueprint.render(@patient_admission)
  end

  def update
    if @patient_admission.update(patient_admission_params)
      render json: PatientAdmissionsBlueprint.render(@patient_admission)
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

end
