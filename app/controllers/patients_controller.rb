class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.active.includes(:patient_files)
    render json: PatientBlueprint.render(@patients)
  end

  def all
    @patients = Patient.all.includes(:patient_files)
    render json: PatientBlueprint.render(@patients)
  end

  def create
    patient_data = patient_params.slice(:full_name, :name, :dob, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex, :monthly_fee, :balance, :covenant, :profile_photo)
    file_data = patient_params.slice(:open_date, :facility, :note)

    ActiveRecord::Base.transaction do
      @patient = Patient.create(patient_data)
      @patient_admission = PatientAdmission.create(patient_id: @patient.id, date: file_data[:open_date])
      @patient_file = PatientFile.create(patient_admission_id: @patient_admission.id, facility: file_data[:facility], open_date: file_data[:open_date], note: file_data[:note])
    end

    if @patient.id != nil
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
    params.permit(:full_name, :name, :dob, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex, :monthly_fee, :balance, :covenant, :profile_photo, :open_date, :facility, :note)
  end
end
