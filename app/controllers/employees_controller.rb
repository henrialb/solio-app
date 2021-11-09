class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show update destroy]

  def index
    @employees = Employee.all
    render json: EmployeeBlueprint.render(@employees)
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: EmployeeBlueprint.render(@employee)
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: EmployeeBlueprint.render(@employee)
  end

  def update
    if @employee.update(employee_params)
      render json: EmployeeBlueprint.render(@employee)
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:user_id, :full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :address, :phone, :email, :role, :nationality)
  end
end
