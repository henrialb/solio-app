class PatientExitsController < ApplicationController
  before_action :set_patient_exit, only: %i[show update destroy]

  def index
    @patient_exits = PatientExit.all
    render json: PatientExitBlueprint.render(@patient_exits)
  end

  def create
    @patient_exit = PatientExit.new(patient_exit_params)
    if @patient_exit.save
      render json: PatientExitBlueprint.render(@patient_exit)
    else
      render json: @patient_exit.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientExitBlueprint.render(@patient_exit)
  end

  def update
    if @patient_exit.update(patient_exit_params)
      render json: PatientExitBlueprint.render(@patient_exit)
    else
      render json: @patient_exit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_exit.destroy
  end

  private

  def set_patient_exit
    @patient_exit = PatientExit.find(params[:id])
  end

  def patient_exit_params
    params.require(:patient_exit).permit(:patient_admission_id, :date, :reason, :location, :note)
  end

end
