class EmployeeAdmissionsController < ApplicationController
  before_action :set_employee_admission, only: %i[show update destroy]

  def index
    @employee_admissions = EmployeeAdmission.all
    render json: EmployeeAdmissionBlueprint.render(@employee_admissions)
  end

  def create
    @employee_admission = EmployeeAdmission.new(employee_admission_params)
    if @employee_admission.save
      render json: EmployeeAdmissionBlueprint.render(@employee_admission)
    else
      render json: @employee_admission.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: EmployeeAdmissionBlueprint.render(@employee_admission)
  end

  def update
    if @employee_admission.update(employee_admission_params)
      render json: EmployeeAdmissionBlueprint.render(@employee_admission)
    else
      render json: @employee_admission.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee_admission.destroy
  end

  private

  def set_employee_admission
    @employee_admission = EmployeeAdmission.find(params[:id])
  end

  def employee_admission_params
    params.require(:employee_admission).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end
end
