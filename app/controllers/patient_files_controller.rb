class PatientFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient_file, only: %i[show update destroy]

  def index
    @patient_files = PatientFile.all
    render json: PatientFileBlueprint.render(@patient_files)
  end

  def create
    @patient_file = PatientFile.new(patient_file_params)
    if @patient_file.save
      render json: PatientFileBlueprint.render(@patient_file)
    else
      render json: @patient_file.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientFileBlueprint.render(@patient_file)
  end

  def update
    if @patient_file.update(patient_file_params)
      render json: PatientFileBlueprint.render(@patient_file)
    else
      render json: @patient_file.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_file.destroy
  end

  private

  def set_patient_file
    @patient_file = PatientFile.find(params[:id])
  end

  def patient_file_params
    params.require(:patient_file).permit(:patient_admission_id, :open_date, :close_date, :facility, :note)
  end
end
