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
    params = patient_params

    pipeline = ImageProcessing::Vips.source(params[:profile_photo])
    params[:profile_photo].tempfile = pipeline.resize_to_fill!(400, 400)

    ActiveRecord::Base.transaction do
      @patient = Patient.create(params)
      @patient_admission = PatientAdmission.create(patient_id: @patient.id, date: file_params[:open_date])
      @patient_file = PatientFile.create(
        patient_admission_id: @patient_admission.id,
        facility: file_params[:facility],
        open_date: file_params[:open_date],
        note: file_params[:note]
      )
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
    params.permit(:full_name, :name, :date_of_birth, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex, :monthly_fee, :balance, :covenant, :profile_photo)
  end

  def file_params
    params.permit(:open_date, :facility, :note)
  end
end
