class PatientExpensesController < ApplicationController
  before_action :set_patient_expense, only: %i[show update destroy]

  def index
    @patient_expenses = PatientExpense.all
    render json: PatientExpenseBlueprint.render(@patient_expenses)
  end

  def patient
    patient = params[:id]
    @patient_expenses = PatientExpense.where(patient_id: patient).includes(:patient_receivable).order(date: :desc)
    render json: PatientExpenseBlueprint.render(@patient_expenses)
  end

  def create
    @patient_expense = PatientExpense.new(patient_expense_params)
    if @patient_expense.save
      render json: PatientExpenseBlueprint.render(@patient_expense)
    else
      render json: @patient_expense.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientExpenseBlueprint.render(@patient_expense)
  end

  def update
    if @patient_expense.update(patient_expense_params)
      render json: PatientExpenseBlueprint.render(@patient_expense)
    else
      render json: @patient_expense.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_expense.destroy
  end

  private

  def set_patient_expense
    @patient_expense = PatientExpense.find(params[:id])
  end

  def patient_expense_params
    params.require(:patient_expense).permit(:patient_file_id, :description, :amount, :note, :date, :patient_id, :patient_receivable_id)
  end
end
