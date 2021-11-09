class PatientRelativesController < ApplicationController
  before_action :set_patient_relative, only: %i[show update destroy]

  def index
    @patient_relatives = PatientRelative.all
    render json: PatientRelativeBlueprint.render(@patient_relatives)
  end

  def create
    @patient_relative = PatientRelative.new(patient_relative_params)
    if @patient_relative.save
      render json: PatientRelativeBlueprint.render(@patient_relative)
    else
      render json: @patient_relative.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientRelativeBlueprint.render(@patient_relative)
  end

  def update
    if @patient_relative.update(patient_relative_params)
      render json: PatientRelativeBlueprint.render(@patient_relative)
    else
      render json: @patient_relative.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_relative.destroy
  end

  private

  def set_patient_relative
    @patient_relative = PatientRelative.find(params[:id])
  end

  def patient_relative_params
    params.require(:patient_relative).permit(:patient_id, :name, :relationship, :phone, :email, :address, :is_main, :note)
  end
end
