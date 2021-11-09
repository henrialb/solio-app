class EmployeeExitsController < ApplicationController
  before_action :set_employee_exit, only: %i[show update destroy]

  def index
    @employee_exits = EmployeeExit.all
    render json: EmployeeExitBlueprint.render(@employee_exits)
  end

  def create
    @employee_exit = EmployeeExit.new(employee_exit_params)
    if @employee_exit.save
      render json: EmployeeExitBlueprint.render(@employee_exit)
    else
      render json: @employee_exit.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: EmployeeExitBlueprint.render(@employee_exit)
  end

  def update
    if @employee_exit.update(employee_exit_params)
      render json: EmployeeExitBlueprint.render(@employee_exit)
    else
      render json: @employee_exit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee_exit.destroy
  end

  private

  def set_employee_exit
    @employee_exit = EmployeeExit.find(params[:id])
  end

  def employee_exit_params
    params.require(:employee_exit).permit(:full_name, :name, :dob, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :sex)
  end
end
