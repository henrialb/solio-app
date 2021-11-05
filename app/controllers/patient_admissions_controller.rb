class PatientAdmissionsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patient_admissions = PatientAdmissions.all
    render json: @patient_admissions
  end

  def create
    @patient_admissions = Patient.new(patient_params)
    if @patient_admissions.save
      render json: PatientAdmissionsBlueprint.render(@patient_admissions)
    else
      render json: @patient_admissions.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientAdmissionsBlueprint.render(@patient_admissions)
  end

  def update
    if @patient_admissions.update(patient_params)
      render json: PatientAdmissionsBlueprint.render(@patient_admissions)
    else
      render json: @patient_admissions.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_admissions.destroy
  end

  private

  def set_patient
    @patient_admissions = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end

end
