class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.all
    render json: PatientBlueprint.render(@patients)
  end

  def create
    @patient = Patient.create(patient_params)
    render json: PatientBlueprint.render(@patient)
  end

  # def new
  # end

  # def edit
  # end

  def show
    render json: PatientBlueprint.render(@patient)
  end

  def update
    @patient.update(patient_params)
    render json: PatientBlueprint.render(@patient)
  end

  def destroy
    @patient.destroy
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end
end
